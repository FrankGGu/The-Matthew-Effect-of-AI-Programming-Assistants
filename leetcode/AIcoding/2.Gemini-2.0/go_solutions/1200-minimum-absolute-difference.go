import "sort"

func minimumAbsDifference(arr []int) [][]int {
	sort.Ints(arr)
	minDiff := arr[1] - arr[0]
	for i := 2; i < len(arr); i++ {
		diff := arr[i] - arr[i-1]
		if diff < minDiff {
			minDiff = diff
		}
	}

	result := [][]int{}
	for i := 1; i < len(arr); i++ {
		if arr[i]-arr[i-1] == minDiff {
			result = append(result, []int{arr[i-1], arr[i]})
		}
	}

	return result
}