func getSumAbsoluteDifferences(nums []int) []int {
	n := len(nums)
	result := make([]int, n)

	prefixSum := make([]int, n+1)
	for i := 0; i < n; i++ {
		prefixSum[i+1] = prefixSum[i