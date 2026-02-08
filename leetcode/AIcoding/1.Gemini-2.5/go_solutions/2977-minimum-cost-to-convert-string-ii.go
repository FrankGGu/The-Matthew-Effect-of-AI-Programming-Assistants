package main

import (
	"math"
)

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func min64(a, b int64) int64 {
	if a < b {
		return a
	}
	return b
}

const (
	P1 = 29
	M1 = 1_000_000_007
	P2 = 31
	M2 = 1_000_000_009
)

type hashPair struct {
	h1 uint64
	h2 uint64
}

func precomputePowers(maxLen int) ([]uint64, []uint64) {
	powers1 := make([]uint64, maxLen+1)
	powers2 := make([]uint64, maxLen+1)
	powers1[0] = 1
	powers2[0] = 1
	for i := 1; i <= maxLen; i++ {
		powers1[i] = (powers1[i-1] * P1) % M1
		powers2[i] = (powers2[i-1] * P2) % M2
	}
	return powers1, powers2
}

func computePrefixHashes(s string, powers1, powers2 []uint64) ([]uint64, []uint64) {
	n := len(s)
	h1 := make([]uint64, n+1)
	h2 := make([]uint64, n+1)
	for i := 0; i < n; i++ {
		// Using (s[i]-'a'+1) to avoid hash of 0 for 'a', which can cause issues
		h1[i+1] = (h1[i]*P1 + uint64(s[i]-'a'+1)) % M1
		h2[i+1] = (h2[i]*P2 + uint64(s[i]-'a'+1)) % M2
	}
	return h1, h2
}

func getSubstringHash(prefixH1, prefixH2, powers1, powers2 []uint64, start, length int) hashPair {
	h1Val := (prefixH1[start+length] - (prefixH1[start]*powers1[length])%M1 + M1) % M1
	h2Val := (prefixH2[start+length] - (prefixH2[start]*powers2[length])%M2 + M2) % M2
	return hashPair{h1Val, h2Val}
}

func minimumCost(source string, target string, original []string, changed []string, cost []int) int64 {
	n := len(source)

	// --- 1. Floyd-Warshall for character conversion costs ---
	charCost := make([][]int, 26)
	for i := range charCost {
		charCost[i] = make([]int, 26)
		for j := range charCost[i] {
			if i == j {
				charCost[i][j] = 0
			} else {
				charCost[i][j] = math.MaxInt // Represents infinity
			}
		}
	}

	// Populate charCost from string arrays if they are single characters
	for k := range original {
		if len(original[k]) == 1 && len(changed[k]) == 1 {
			c1 := original[k][0] - 'a'
			c2 := changed[k][0] - 'a'
			charCost[c1][c2] = min(charCost[c1][c2], cost[k])
		}
	}

	// Floyd-Warshall
	for k := 0; k < 26; k++ {
		for i := 0; i < 26; i++ {
			for j := 0; j < 26; j++ {
				if charCost[i][k] != math.MaxInt && charCost[k][j] != math.MaxInt {
					charCost[i][j] = min(charCost[i][j], charCost[i][k]+charCost[k][j])
				}
			}
		}
	}

	// --- 2. Hashing setup ---
	// Determine max length for precomputing powers and for DP loop
	maxStrLen := 0
	for _, s := range original {
		if len(s) > maxStrLen {
			maxStrLen = len(s)
		}
	}
	for _, s := range changed {
		if len(s) > maxStrLen {
			maxStrLen = len(s)
		}
	}

	// Powers needed up to max(n, maxStrLen)
	// For source/target substrings, max length is n.
	// For original/changed strings, max length is maxStrLen.
	// So precompute up to max(n, maxStrLen)
	maxOverallLen := n
	if maxStrLen > maxOverallLen {
		maxOverallLen = maxStrLen
	}

	powers1, powers2 := precomputePowers(maxOverallLen)

	sPrefixH1, sPrefixH2 := computePrefixHashes(source, powers1, powers2)
	tPrefixH1, tPrefixH2 := computePrefixHashes(target, powers1, powers2)

	// --- 3. Preprocessing String Conversion Costs (with Hashing) ---
	stringMinCosts := make(map[hashPair]map[hashPair]int)
	for k := range original {
		if len(original[k]) == 1 { // Skip single char conversions, already handled by charCost
			continue
		}

		// Compute hashes for original[k] and changed[k]
		origPH1, origPH2 := computePrefixHashes(original[k], powers1, powers2)
		chgPH1, chgPH2 := computePrefixHashes(changed[k], powers1, powers2)

		origHash := getSubstringHash(origPH1, origPH2, powers1, powers2, 0, len(original[k]))
		chgHash := getSubstringHash(chgPH1, chgPH2, powers1, powers2, 0, len(changed[k]))

		if _, ok := stringMinCosts[origHash]; !ok {
			stringMinCosts[origHash] = make(map[hashPair]int)
		}
		if currentCost, ok := stringMinCosts[origHash][chgHash]; !ok || cost[k] < currentCost {
			stringMinCosts[origHash][chgHash] = cost[k]
		}
	}

	// --- 4. Dynamic Programming ---
	dp := make([]int64, n+1)
	dp[0] = 0
	for i := 1; i <= n; i++ {
		dp[i] = math.MaxInt64
	}

	for i := 1; i <= n; i++ {
		if dp[i-1] != math.MaxInt64 { // Check if previous state is reachable
			// Option A: Convert source[i-1] to target[i-1] (single character)
			char1 := source[i-1] - 'a'
			char2 := target[i-1] - 'a'
			charConvCost := charCost[char1][char2]
			if charConvCost != math.MaxInt { // Check if char conversion is possible
				dp[i] = min64(dp[i], dp[i-1]+int64(charConvCost))
			}
		}

		// Option B: Convert a substring source[j...i-1] to target[j...i-1]
		// Iterate over possible lengths of the substring ending at i-1
		for lenS := 1; lenS <= min(i, maxStrLen); lenS++ { // maxStrLen is the max length of any original/changed string
			j := i - lenS // Starting index of the substring

			if dp[j] == math.MaxInt64 { // Cannot reach this starting point
				continue
			}

			// Get hashes for source[j:i] and target[j:i]
			subSourceHash := getSubstringHash(sPrefixH1, sPrefixH2, powers1, powers2, j, lenS)
			subTargetHash := getSubstringHash(tPrefixH1, tPrefixH2, powers1, powers2, j, lenS)

			if costsMap, ok := stringMinCosts[subSourceHash]; ok {
				if strConvCost, ok := costsMap[subTargetHash]; ok {
					dp[i] = min64(dp[i], dp[j]+int64(strConvCost))
				}
			}
		}
	}

	if dp[n] == math.MaxInt64 {
		return -1
	}
	return dp[n]
}