package main

import (
	"math"
)

func check(k int, paths [][]int) bool {
	if k == 0 {
		return true
	}

	numPaths := len(paths)

	base1, mod1 := uint64(31), uint64(1_000_000_007)
	base2, mod2 := uint64(37), uint64(1_000_000_009)

	pow1 := make([]uint64, k+1)
	pow2 := make([]uint64, k+1)
	pow1[0], pow2[0] = 1, 1
	for i := 1; i <= k; i++ {
		pow1[i] = (pow1[i-1] * base1) % mod1
		pow2[i] = (pow2[i-1] * base2) % mod2
	}

	base1_pow_k_minus_1 := pow1[k-1]
	base2_pow_k_minus_1 := pow2[k-1]

	currentHashes := make(map[uint64]struct{})

	path0 := paths[0]
	if len(path0) < k {
		return false
	}

	h1, h2 := uint64(0), uint64(0)
	for i := 0; i < k; i++ {
		h1 = (h1*base1 + uint64(path0[i])) % mod1
		h2 = (h2*base2 + uint64(path0[i])) % mod2
	}
	currentHashes[h1<<32|h2] = struct{}{}

	for i := k; i < len(path0); i++ {
		h1 = (h1 - (uint64(path0[i-k])*base1_pow_k_minus_1)%mod1 + mod1) % mod1
		h2 = (h2 - (uint64(path0[i-k])*base2_pow_k_minus_1)%mod2 + mod2) % mod2
		h1 = (h1*base1 + uint64(path0[i])) % mod1
		h2 = (h2*base2 + uint64(path0[i])) % mod2
		currentHashes[h1<<32|h2] = struct{}{}
	}

	for pIdx := 1; pIdx < numPaths; pIdx++ {
		path := paths[pIdx]
		if len(path) < k {
			return false
		}

		nextHashes := make(map[uint64]struct{})
		h1, h2 = uint64(0), uint64(0)

		for i := 0; i < k; i++ {
			h1 = (h1*base1 + uint64(path[i])) % mod1
			h2 = (h2*base2 + uint64(path[i])) % mod2
		}
		combinedHash := h1<<32 | h2
		if _, ok := currentHashes[combinedHash]; ok {
			nextHashes[combinedHash] = struct{}{}
		}

		for i := k; i < len(path); i++ {
			h1 = (h1 - (uint64(path[i-k])*base1_pow_k_minus_1)%mod1 + mod1) % mod1
			h2 = (h2 - (uint64(path[i-k])*base2_pow_k_minus_1)%mod2 + mod2) % mod2
			h1 = (h1*base1 + uint64(path[i])) % mod1
			h2 = (h2*base2 + uint64(path[i])) % mod2
			combinedHash = h1<<32 | h2
			if _, ok := currentHashes[combinedHash]; ok {
				nextHashes[combinedHash] = struct{}{}
			}
		}

		currentHashes = nextHashes
		if len(currentHashes) == 0 {
			return false
		}
	}

	return true
}

func longestCommonSubpath(n int, paths [][]int) int {
	minLen := math.MaxInt32
	for _, p := range paths {
		if len(p) < minLen {
			minLen = len(p)
		}
	}

	low, high := 0, minLen
	ans := 0

	for low <= high {
		mid := low + (high-low)/2
		if check(mid, paths) {
			ans = mid
			low = mid + 1
		} else {
			high = mid - 1
		}
	}
	return ans
}