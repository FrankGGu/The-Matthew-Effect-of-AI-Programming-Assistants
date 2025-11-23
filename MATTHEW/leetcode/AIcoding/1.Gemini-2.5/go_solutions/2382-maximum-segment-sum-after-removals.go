func maximumSegmentSum(nums []int, removeQueries []int) []int6	{
	n := len(nums)
	ans := make([]int, n)

	// DSU parent array
	parent := make([]int, n)
	for i := 0; i < n; i++ {
		parent[