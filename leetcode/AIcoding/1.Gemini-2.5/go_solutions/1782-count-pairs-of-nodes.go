package main

import (
	"sort"
)

const MOD int = 998244353 // A prime of the form c * 2^k + 1
const ROOT int = 3        // Primitive root modulo MOD

func pow(base, exp int) int {
	res := 1
	base %= MOD
	for exp > 0 {
		if exp%2 == 1 {
			res = (res * base) % MOD
		}
		base = (base * base) % MOD
		exp /= 2
	}
	return res
}

func inv(n int) int {
	return pow(n, MOD-2)
}

func ntt(a []int, inverse bool) {
	n := len(a)

	// Bit-reversal permutation
	j := 0
	for i := 1; i < n; i++ {
		if j < i {
			a[i], a[j] = a[j], a[i]
		}
		k := n / 2
		for k <= j {
			j -= k
			k /= 2
		}
		j += k
	}

	// Iterative butterfly operations
	for len_ := 2; len_ <= n; len_ <<= 1 {
		wlen := pow(ROOT, (MOD-1)/len_)
		if inverse {
			wlen = inv(wlen)
		}

		for i := 0; i < n; i += len_ {
			w := 1
			for j := 0; j < len_/2; j++ {
				u := a[i+j]
				v := (a[i+j+len_/2] * w) % MOD
				a[i+j] = (u + v) % MOD
				a[i+j+len_/2] = (u - v + MOD) % MOD // Ensure positive result
				w = (w * wlen) % MOD
			}
		}
	}

	// If inverse transform, divide by n
	if inverse {
		nInv := inv(n)
		for i := 0; i < n; i++ {
			a[i] = (a[i] * nInv) % MOD
		}
	}
}

func multiply(a, b []int) []int {
	lenA := len(a)
	lenB := len(b)
	resultLen := lenA + lenB - 1

	// Pad to next power of 2
	n := 1
	for n < resultLen {
		n <<= 1
	}

	polyA := make([]int, n)
	copy(polyA, a)
	polyB := make([]int, n)
	copy(polyB, b)

	ntt(polyA, false)
	ntt(polyB, false)

	polyC := make([]int, n)
	for i := 0; i < n; i++ {
		polyC[i] = (polyA[i] * polyB[i]) % MOD
	}

	ntt(polyC, true)

	return polyC[:resultLen]
}

func countPairsOfNodes(n int, edges [][]int, queries []int) []int {
	deg := make([]int, n+1)
	// Using a map to store edges for O(1) average lookup.
	// Key is a pair [min(u,v), max(u,v)]
	edgeSet := make(map[[2]int]bool)

	for _, edge := range edges {
		u, v := edge[0], edge[1]
		deg[u]++
		deg[v]++
		if u > v {
			u, v = v, u
		}
		edgeSet[[2]int{u, v}] = true
	}

	// Step 3: Create degreeCounts for NTT
	// degreeCounts[d] = number of nodes with degree d
	// Max degree can be n-1. Array size n covers degrees 0 to n-1.
	degreeCounts := make([]int, n)
	for i := 1; i <= n; i++ {
		degreeCounts[deg[i]]++
	}

	// Step 4: Compute freqSum using NTT
	// freqSum[k] = count of pairs (u,v) with u<v such that deg(u)+deg(v)=k
	// P(x) = sum_{d=0}^{n-1} degreeCounts[d] * x^d
	// P_sq(x) = P(x) * P(x)
	// The coefficients of P_sq(x) are sum_{i+j=k} degreeCounts[i] * degreeCounts[j]
	// This counts ordered pairs (i,j).

	// Max possible sum of degrees is 2*(n-1). Result length will be 2*(n-1)+1.
	polyResult := multiply(degreeCounts, degreeCounts)

	freqSum := make([]int64, 2*n+1) // Max sum is 2*(n-1).
	for k := 0; k < len(polyResult); k++ {
		if k >= len(freqSum) { // Cap at 2*n (max possible sum + 1)
			break
		}
		val := int64(polyResult[k]) // polyResult[k] is the sum of products, which is the actual count if < MOD

		if k%2 == 0 { // k = 2 * d
			d := k / 2
			if d < n { 
				// Remove (d,d) contribution (degreeCounts[d] * degreeCounts[d])
				val -= int64(degreeCounts[d]) * int64(degreeCounts[d])
				// Divide by 2 for (i,j) and (j,i) where i!=j
				val /= 2
				// Add correct (d,d) contribution (degreeCounts[d] * (degreeCounts[d]-1) / 2)
				val += int64(degreeCounts[d]) * int64(degreeCounts[d]-1) / 2
			} else { // if d >= n, degree d doesn't exist, degreeCounts[d] is 0.
				val /= 2
			}
		} else { // k = i+j, i!=j
			val /= 2
		}
		freqSum[k] = val
	}

	// Step 5: Compute suffix sums for freqSum
	// suffixFreqSum[k] = sum_{s=k}^{2*(n-1)} freqSum[s]
	suffixFreqSum := make([]int64, 2*n+1)
	for k := 2*n - 1; k >= 0; k-- {
		suffixFreqSum[k] = suffixFreqSum[k+1] + freqSum[k]
	}

	// Step 6: Compute edgeSumCounts
	// edgeSumCounts[k] = count of edges (u,v) such that deg(u)+deg(v)=k
	edgeSumCounts := make([]int, 2*n+1)
	for edge := range edgeSet {
		u, v := edge[0], edge[1]
		sumDeg := deg[u] + deg[v]
		edgeSumCounts[sumDeg]++
	}

	// Step 7 & 8: Answer queries
	results := make([]int, len(queries))
	for i, q := range queries {
		// base_count = #{(u,v) | u<v, deg(u)+deg(v) > q}
		// This is suffixFreqSum[q+1]
		baseCount := int64(0)
		if q+1 < len(suffixFreqSum) {
			baseCount = suffixFreqSum[q+1]
		}

		// adjustment = #{(u,v) | (u,v) is an edge, deg(u)+deg(v) == q+1}
		adjustment := 0
		if q+1 < len(edgeSumCounts) {
			adjustment = edgeSumCounts[q+1]
		}

		results[i] = int(baseCount) - adjustment
	}

	return results
}