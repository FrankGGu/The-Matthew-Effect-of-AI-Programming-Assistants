package main

import (
	"sort"
)

func maximumBeauty(flowers []int, newFlowers int64, target int, full int, partial int) int64 {
	n := len(flowers)
	sort.Ints(flowers)

	prefixSum := make([]int64, n+1)
	for i := 0; i < n; i++ {
		prefixSum[i+1] = prefixSum[i] + int64(flowers[i])
	}

	maxBeauty := int64(0)
	currentFullCost := int64(0)

	// Iterate 'i' from 'n' down to '0'.
	// 'i' represents the number of gardens considered for partial beauty (flowers[0...i-1]).
	// 'n-i' represents the number of gardens considered for full beauty (flowers[i...n-1]).
	for i := n; i >= 0; i-- {
		// Calculate cost for full gardens (flowers[i...n-1])
		// These are the gardens from the right end of the sorted array,
		// which are the largest ones, minimizing the cost to make them full.
		if i < n {
			costForThisGarden := 0
			if flowers[i] < target {
				costForThisGarden = target - flowers[i]
			}
			currentFullCost += int64(costForThisGarden)
		}

		if currentFullCost > newFlowers {
			// Cannot afford to make these 'n-i' gardens full.
			// Since we are iterating from right to left (making more gardens full),
			// further iterations would only increase currentFullCost. So, break.
			break
		}

		currentConfigBeauty := int64(n-i) * int64(full)
		remainingFlowersForPartial := newFlowers - currentFullCost

		if i > 0 { // If there are gardens for partial beauty (flowers[0...i-1])
			// Binary search for the maximum possible 'minFlowers' (mF) for gardens[0...i-1]
			// mF must be less than target, as reaching target makes it a full garden.
			low := 0
			high := target - 1
			currentMinFlowers := 0

			for low <= high {
				mid := low + (high-low)/2

				// Find the number of gardens in flowers[0...i-1] that are less than 'mid'.
				// sort.SearchInts returns the index of the first element >= mid.
				// So, `idx` elements are strictly less than mid.
				idx := sort.SearchInts(flowers[0:i], mid)

				// Calculate cost to raise these `idx` gardens to `mid`.
				// The sum of flowers[0...idx-1] is prefixSum[idx].
				costToRaise := int64(idx)*int64(mid) - prefixSum[idx]

				if costToRaise <= remainingFlowersForPartial {
					currentMinFlowers = mid
					low = mid + 1
				} else {
					high = mid - 1
				}
			}
			currentConfigBeauty += int64(currentMinFlowers) * int64(partial)
		}

		maxBeauty = max(maxBeauty, currentConfigBeauty)
	}

	return maxBeauty
}

func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}