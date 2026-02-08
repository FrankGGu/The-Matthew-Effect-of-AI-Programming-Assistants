import (
	"math"
	"sort"
)

func upper_bound(arr []int, val int) int {
	return sort.SearchInts(arr, val+1)
}

func makeArrayIncreasing(arr1 []int, arr2 []int) int {
	// Sort arr2 and remove duplicates to optimize binary search
	sort.Ints(arr2)
	uniqueArr2 := make([]int, 0, len(arr2))
	if len(arr2) > 0 {
		uniqueArr2 = append(uniqueArr2, arr2[0])
		for i := 1; i < len(arr2); i++ {
			if arr2[i] != arr2[i-1] {
				uniqueArr2 = append(uniqueArr2, arr2[i])
			}
		}
	}
	arr2 = uniqueArr2

	// dp[k] stores the minimum last element of a strictly increasing array
	// that was formed using k replacement operations.
	// Initialize dp[0] to -1, representing a virtual element before the start
	// that allows any first element of arr1 (or arr2) to be greater than it.
	dp := map[int]int{0: -1}

	for _, num1 := range arr1 {
		newDp := make(map[int]int)

		// Iterate through all current valid states (ops, prevVal)
		for ops, prevVal := range dp {
			// Option 1: Don't replace num1
			// If num1 is strictly greater than the previous element (prevVal),
			// we can potentially extend the sequence without replacement.
			if num1 > prevVal {
				// Update newDp[ops] if num1 offers a smaller last element
				// for the same number of operations.
				if currentMin, exists := newDp[ops]; !exists || num1 < currentMin {
					newDp[ops] = num1
				}
			}

			// Option 2: Replace num1 with an element from arr2
			// Find the smallest element in arr2 that is strictly greater than prevVal.
			idx := upper_bound(arr2, prevVal)
			if idx < len(arr2) {
				valFromArr2 := arr2[idx]
				newOps := ops + 1 // One more operation used
				// Update newDp[newOps] if valFromArr2 offers a smaller last element
				// for the new number of operations.
				if currentMin, exists := newDp[newOps]; !exists || valFromArr2 < currentMin {
					newDp[newOps] = valFromArr2
				}
			}
		}
		dp = newDp // Update dp for the next iteration
	}

	// After processing all elements of arr1, find the minimum number of operations.
	minOps := math.MaxInt32
	if len(dp) == 0 {
		// If dp is empty, no strictly increasing array could be formed.
		return -1
	}

	for ops := range dp {
		if ops < minOps {
			minOps = ops
		}
	}

	return minOps
}