import (
	"math"
)

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func minSizeSubarray(nums []int, target int) int {
	n := len(nums)
	sumArr := 0
	for _, x := range nums {
		sumArr += x
	}

	if target == 0 {
		return 0
	}

	// --- Calculate minLenForRemainder (for k*n + remainder_length) ---
	// This path considers forming the target by using 'k' full repetitions of 'nums'
	// and then finding the remaining 'remainder' in a segment of 'nums + nums'.
	k := 0
	remainder := target
	if sumArr != 0 {
		k = target / sumArr
		remainder = target % sumArr
	}
	// If sumArr is 0, k remains 0 and remainder remains target.
	// In this case, this path effectively searches for 'target' itself within 'nums + nums'
	// and adds 0 for the 'k*n' part.

	minLenForRemainder := math.MaxInt
	currentSum := 0
	prefixSumMap := make(map[int]int)
	prefixSumMap[0] = -1 // Sum 0 exists conceptually before index 0

	// Iterate over `nums` concatenated with itself once (`nums + nums`)
	// This allows finding subarrays that wrap around the original array.
	for i := 0; i < 2*n; i++ {
		val := nums[i%n]
		currentSum += val

		// Check if `currentSum - remainder` has been seen before
		if prevIndex, ok := prefixSumMap[currentSum-remainder]; ok {
			minLenForRemainder = min(minLenForRemainder, i-prevIndex)
		}
		// Always update the map with the latest index for currentSum.
		// This is crucial for finding the minimum length subarray:
		// To minimize `i - prevIndex`, `prevIndex` should be as large as possible.
		// So, if multiple prefixes sum to the same value, we want the one that ends latest.
		prefixSumMap[currentSum] = i
	}

	// --- Calculate minLenDirectTarget (for target found directly within 2*n elements) ---
	// This path considers forming the target entirely within a segment of `nums + nums`
	// (i.e., less than 2*n elements), without explicitly accounting for full repetitions.
	// This is important because sometimes a direct subarray (e.g., [1,2,3,4] for target=10)
	// might be shorter than a combination involving full arrays (e.g., [1,2,3,4,5] + [5] for target=20).
	minLenDirectTarget := math.MaxInt
	currentSum = 0 // Reset currentSum and map for this calculation
	prefixSumMap = make(map[int]int)
	prefixSumMap[0] = -1

	for i := 0; i < 2*n; i++ {
		val := nums[i%n]
		currentSum += val

		if prevIndex, ok := prefixSumMap[currentSum-target]; ok {
			minLenDirectTarget = min(minLenDirectTarget, i-prevIndex)
		}
		prefixSumMap[currentSum] = i
	}

	// Candidate 1: Length using full array repetitions + remainder
	ans1 := math.MaxInt
	if minLenForRemainder != math.MaxInt { // Only if remainder part is achievable
		ans1 = k*n + minLenForRemainder
	}

	// Candidate 2: Length using a direct subarray within 2*n elements
	ans2 := minLenDirectTarget

	// The overall minimum is the smaller of the two candidates
	finalAns := min(ans1, ans2)

	if finalAns == math.MaxInt {
		return -1 // Target cannot be formed
	}
	return finalAns
}