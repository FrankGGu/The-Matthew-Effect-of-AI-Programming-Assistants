import (
	"sort"
)

func fullBloomFlowers(flowers [][]int, people []int) []int {
	n := len(flowers)
	starts := make([]int, n)
	ends := make([]int, n)
	for i, flower := range flowers {
		starts[i] = flower[0]
		ends[i] = flower[1] + 1
	}
	sort.Ints(starts)
	sort.Ints(ends)

	res := make([]int, len(people))
	for i, t := range people {
		start := sort.Search(n, func(j int) bool { return starts[j] > t })
		end := sort.Search(n, func(j int) bool { return ends[j] > t })
		res[i] = start - end
	}
	return res
}