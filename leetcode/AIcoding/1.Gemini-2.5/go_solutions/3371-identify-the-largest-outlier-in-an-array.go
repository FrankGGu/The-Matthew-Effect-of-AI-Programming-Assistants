import "math"

func largestOutlier(nums []int) int {
	if len(nums) == 0 {
		return -1
	}

	freqMap := make(map[int]int)
	for _, num := range nums {
		freqMap[num]++
	}

	maxOutlier :=