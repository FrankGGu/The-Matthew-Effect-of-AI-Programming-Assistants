import "sort"

func maxChunksToSorted(arr []int) int {
	n := len(arr)
	if n == 0 {
		return 0
	}

	// Create a sorted version of the array
	sortedArr := make([]int, n)
	copy(sortedArr, arr)
	sort.Int