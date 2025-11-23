import "math"

func maxSubarrays(nums []int) int {
	n := len(nums)

	// Calculate the bitwise AND of the entire array.
	// If the bitwise AND of all elements is greater than 0,
	// it means there's at least one bit position that is set in ALL numbers.
	// In this scenario, any single element `nums[i]` will also have that bit set (since `nums[i] >= 1`).
	// Therefore, each individual element `[nums[i]]` forms a valid subarray (its AND is `nums[i] > 0`).
	// This allows us to split the array into `n` subarrays, each containing a single element.
	// This is the maximum possible number of subarrays.
	totalAND := nums[0]
	for i := 1; i < n; i++ {
		totalAND &= nums[i]
	}

	if totalAND > 0 {
		return n
	}

	// If the bitwise AND of the entire array is 0, we cannot use the entire array as one subarray.
	// We must split the array. The goal is to maximize the number of subarrays.
	// We use a greedy approach:
	// We maintain a `currentSegmentAND` for the current subarray being formed.
	// We try to extend this subarray as much as possible.
	// If adding an element `num` makes `currentSegmentAND` become 0, it means:
	// 1. The elements processed *before* `num` in the current segment formed a valid subarray (whose AND was > 0).
	// 2. `num` cannot be included in that segment if we want its AND to remain > 0.
	// So, we "cut" the array at the element before `num`, count the completed subarray,
	// and start a new subarray beginning with `num`.

	numSplits := 0
	// Initialize `currentSegmentAND` to `math.MaxInt32` (all bits set for positive integers)
	// to ensure the first element `num` correctly initializes the AND for the first segment.
	currentSegmentAND := math.MaxInt32 

	for _, num := range nums {
		currentSegmentAND &= num
		if currentSegmentAND == 0 {
			// A segment has been completed because adding `num` made its AND zero.
			// This means the segment ending just before `num` was a valid one.
			numSplits++
			// Reset `currentSegmentAND` for the next segment.
			// The next element in the loop will then start a new segment.
			currentSegmentAND = math.MaxInt32
		}
	}

	// `numSplits` counts the number of times we were forced to make a split.
	// Each split completes a segment. The very last segment formed (which didn't necessarily
	// cause `currentSegmentAND` to become 0) also needs to be counted.
	// If `numSplits` is 0, it means `currentSegmentAND` never became 0,
	// but this case is already handled by `totalAND > 0` returning `n`.
	// For `totalAND == 0`, `numSplits` will be at least 1.
	// The `+1` accounts for the final segment that is always present.
	return numSplits + 1
}