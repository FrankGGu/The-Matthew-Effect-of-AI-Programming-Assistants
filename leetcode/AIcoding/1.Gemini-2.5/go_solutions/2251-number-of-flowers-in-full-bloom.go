import (
	"sort"
)

func fullBloomFlowers(flowers [][]int, people []int) []int {
	n := len(flowers)
	starts := make([]int, n)
	ends := make([]int, n)

	for i := 0; i < n; i++ {
		starts[i] = flowers[i][0]
		ends[i] = flowers[i][1]
	}

	sort.Ints(starts)
	sort.Ints(ends)

	m := len(people)
	ans := make([]int, m)

	for i := 0; i < m; i++ {
		personTime := people[i]

		startedCount := sort.SearchInts(starts, personTime+1)

		endedBeforeCount := sort.SearchInts(ends, personTime)

		ans[i] = startedCount - endedBeforeCount
	}

	return ans
}