import "sort"

func fullBloomFlowers(flowers [][]int, people []int) []int {
	starts := make([]int, len(flowers))
	ends := make([]int, len(flowers))
	for i, flower := range flowers {
		starts[i] = flower[0]
		ends[i] = flower[1] + 1
	}
	sort.Ints(starts)
	sort.Ints(ends)

	ans := make([]int, len(people))
	for i, person := range people {
		startCount := sort.SearchInts(starts, person+1)
		endCount := sort.SearchInts(ends, person+1)
		ans[i] = startCount - endCount
	}
	return ans
}