import "sort"

func findSpecialInteger(arr []int) int {
	n := len(arr)
	if n == 1 {
		return arr[0]
	}

	quarter := n / 4

	candidates := []int{arr[0], arr[quarter], arr[2*quarter], arr[3*quarter]}

	for _, candidate := range candidates {
		firstIdx := sort.SearchInts(arr, candidate)
		nextValIdx := sort.SearchInts(arr, candidate+1)

		count := nextValIdx - firstIdx

		if count > quarter {
			return candidate
		}
	}

	return -1 
}