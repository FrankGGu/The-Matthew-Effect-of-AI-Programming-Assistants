import "math"

func minAbsoluteDifferenceQueries(nums []int, queries [][]int) []int {
	n := len(nums)
	maxVal := 100 // nums[i] are between 1 and 100

	// prefixCount[i][j] stores the count of number j in nums[0...i-1]
	prefixCount := make([][]int, n+1)
	for i := range prefixCount {
		prefixCount[i] = make([]int, maxVal+1)
	}

	for i := 0; i < n; i++ {
		// Copy counts from previous prefix
		copy(prefixCount[i+1], prefixCount[i])
		// Increment count for the current number
		prefixCount[i+1][nums[i]]++
	}

	ans := make([]int, len(queries))

	for qIdx, query := range queries {
		l, r := query[0], query[1]

		// If the subarray has less than two elements, no distinct pair can be formed.
		if r-l+1 < 2 {
			ans[qIdx] = -1
			continue
		}

		// Determine which numbers are present in the current range [l, r]
		present := make([]bool, maxVal+1)
		for val := 1; val <= maxVal; val++ {
			if prefixCount[r+1][val]-prefixCount[l][val] > 0 {
				present[val] = true
			}
		}

		minDiff := math.MaxInt32 // Initialize with a very large value
		lastPresentVal := -1

		// Iterate through possible values to find the minimum difference
		for val := 1; val <= maxVal; val++ {
			if present[val] {
				if lastPresentVal != -1 {
					diff := val - lastPresentVal
					if diff < minDiff {
						minDiff = diff
					}
				}
				lastPresentVal = val
			}
		}

		if minDiff == math.MaxInt32 { // No two distinct numbers found
			ans[qIdx] = -1
		} else {
			ans[qIdx] = minDiff
		}
	}

	return ans
}