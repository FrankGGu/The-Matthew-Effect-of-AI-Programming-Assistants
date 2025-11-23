func countSubarrays(nums []int, minK int, maxK int) int6s {
	var ans int64
	leftBound := -1
	lastMinK := -1
	lastMaxK := -1

	for i := 0; i < len(nums); i++ {
		if nums