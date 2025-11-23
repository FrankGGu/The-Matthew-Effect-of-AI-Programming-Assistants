import "math"

func maximizeTheTopmostElement(nums []int, k int) int {
	n := len(nums)

	// Edge case: No moves allowed. The topmost element is nums[0].
	if k == 0 {
		return nums[0]
	}

	// Edge case: Only one element in the array.
	if n == 1 {
		// If k is odd, we remove the only element, and the array becomes empty.
		// We cannot put it back and have it as the topmost after an odd number of moves.
		// So, no element can be at the top.
		if k%2 == 1 {
			return -1
		}
		// If k is even, we can remove the element and put it back k/2 times.
		// The element nums[0] will be at the top.
		return nums[0]
	}

	// Special case: If k is large enough to remove all elements (k >= n)
	// AND the remaining moves (k-n) are even.
	// In this scenario, we can always remove all elements (n moves), then
	// for each pair of remaining moves, we can put an element back and immediately remove it.
	// This results in an empty array after k moves.
	// This applies if k > n. If k == n, k-n is 0 (even), but it's handled by the loop below.
	if k > n && (k-n)%2 == 0 {
		return -1
	}

	maxVal := -1

	// Strategy 1: The topmost element is nums[k].
	// This happens if we simply remove the first k elements (nums[0] through nums[k-1]).
	// This is possible only if k is less than the array length n.
	if k < n {
		maxVal = int(math.Max(float64(maxVal), float64(nums[k])))
	}

	// Strategy 2: An element nums[i] (where i < k) is removed and then put back.
	// To make nums[i] the topmost:
	// 1. Remove nums[0] through nums[i] (i+1 moves).
	// 2. Put nums[i] back (1 move).
	// Total moves used: (i+1) + 1 = i+2.
	// We must have i+2 <= k, which means i <= k-2.
	// Also, i must be a valid index, so i < n.
	// Therefore, i ranges from 0 up to min(n-1, k-2).
	// The remaining k-(i+2) moves can be used by repeatedly removing and putting back nums[i]
	// without changing the topmost element. This strategy always works for these i.
	upperBound := int(math.Min(float64(n-1), float64(k-2)))
	for i := 0; i <= upperBound; i++ {
		maxVal = int(math.Max(float64(maxVal), float64(nums[i])))
	}

	return maxVal
}