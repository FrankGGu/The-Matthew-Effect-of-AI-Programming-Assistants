import "sort"

func heightChecker(heights []int) int {
	n := len(heights)
	expected := make([]int, n)
	copy(expected, heights)
	sort.Ints(expected)
	count := 0
	for i := 0; i < n; i++ {
		if heights[i] != expected[i] {
			count++
		}
	}
	return count
}