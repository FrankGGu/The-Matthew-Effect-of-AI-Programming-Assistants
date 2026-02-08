import "sort"

func hIndex(citations []int) int {
	sort.Sort(sort.Reverse(sort.IntSlice(citations)))
	n := len(citations)
	for i := 0; i < n; i++ {
		if citations[i] < i+1 {
			return i
		}
	}
	return n
}