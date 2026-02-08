func componentValue(nums []int, edges [][]int) int {
	n := len(nums)
	if n == 1 {
		return 1
	}

	adj := make([][]int, n)
	for _, edge := range edges {
		u, v