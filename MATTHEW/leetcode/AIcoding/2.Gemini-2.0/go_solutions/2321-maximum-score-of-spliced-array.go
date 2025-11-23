import "math"

func maximumsSplicedArray(nums1 []int, nums2 []int) int {
	n := len(nums1)

	sum1 := 0
	sum2 := 0

	for i := 0; i < n; i++ {
		sum1 += nums1[i]
		sum2 += nums2[i]
	}

	maxSum1 := sum1
	maxSum2 := sum2

	diff1 := make([]int, n)
	diff2 := make([]int, n)

	for i := 0; i < n; i++ {
		diff1[i] = nums2[i] - nums1[i]
		diff2[i] = nums1[i] - nums2[i]
	}

	currentMax1 := 0
	maxDiff1 := 0
	for i := 0; i < n; i++ {
		currentMax1 += diff1[i]
		if currentMax1 < 0 {
			currentMax1 = 0
		}
		maxDiff1 = int(math.Max(float64(maxDiff1), float64(currentMax1)))
	}

	currentMax2 := 0
	maxDiff2 := 0
	for i := 0; i < n; i++ {
		currentMax2 += diff2[i]
		if currentMax2 < 0 {
			currentMax2 = 0
		}
		maxDiff2 = int(math.Max(float64(maxDiff2), float64(currentMax2)))
	}

	maxSum1 += maxDiff1
	maxSum2 += maxDiff2

	return int(math.Max(float64(maxSum1), float64(maxSum2)))
}