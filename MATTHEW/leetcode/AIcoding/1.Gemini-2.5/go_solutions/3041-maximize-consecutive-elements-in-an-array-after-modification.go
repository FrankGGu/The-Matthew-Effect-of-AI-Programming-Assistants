import (
	"sort"
)

func maximizeConsecutive(nums []int) int {
	sort.Ints(nums)

	uniqueNums := []int{}
	if len(nums) > 0 {
		uniqueNums = append(uniqueNums, nums[0])
	}
	for i := 1; i < len(nums); i++ {
		if nums[i] != nums[i-1] {
			uniqueNums = append(uniqueNums, nums[i])
		}
	}
	nums = uniqueNums
	n := len(nums)

	if n == 0 {
		return 0
	}
	if n == 1 {
		return 1
	}

	maxLen := 0
	left := 0
	decrementsUsed := 0 // This counts the total number of "missing" elements in the current window [left, right]

	for right := 0; right < n; right++ {
		if right > 0 {
			gap := nums[right] - nums[right-1]
			if gap > 1 {
				decrementsUsed += (gap - 1)
			}
		}

		// Shrink the window from the left if we've used more than one effective decrement.
		// `decrementsUsed` represents the total "missing" elements in `nums[left...right]`.
		// We can bridge at most one missing element using our single modification.
		// So, `decrementsUsed` must be 0 or 1 for a valid window.
		for decrementsUsed > 1 && left < right {
			// When `left` moves, the gap `nums[left+1] - nums[left]` is no longer part of the window.
			// Its contribution `(nums[left+1] - nums[left] - 1)` must be removed from `decrementsUsed`.
			gapAfterLeft := nums[left+1] - nums[left]
			decrementsUsed -= (gapAfterLeft - 1)
			left++
		}

		// Calculate current length based on the valid window [left, right]
		// `right - left + 1` is the number of elements in the window.
		// If `decrementsUsed == 0`, it means the elements are already consecutive. We can use the one decrement
		// to extend the sequence by 1 (e.g., change `nums[left]` to `nums[left]-1` or `nums[right]` to `nums[right]+1` effectively).
		// So, length is `(right - left + 1) + 1`.
		// If `decrementsUsed == 1`, it means there's exactly one gap of size 2 (e.g., X, X+2). We use the decrement
		// to bridge this gap (e.g., X, X+1). The length is `(right - left + 1)`.
		currentLen := right - left + 1
		if decrementsUsed == 0 {
			currentLen++
		}

		if currentLen > maxLen {
			maxLen = currentLen
		}
	}

	return maxLen
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}