import "sort"

func sortByBits(arr []int) []int {
	sort.Slice(arr, func(i, j int) bool {
		countI := countBits(arr[i])
		countJ := countBits(arr[j])
		if countI == countJ {
			return arr[i] < arr[j]
		}
		return countI < countJ
	})
	return arr
}

func countBits(n int) int {
	count := 0
	for n > 0 {
		n &= (n - 1)
		count++
	}
	return count
}