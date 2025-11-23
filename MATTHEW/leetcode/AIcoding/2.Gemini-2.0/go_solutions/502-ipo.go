import (
	"container/heap"
	"sort"
)

type Project struct {
	profit int
	capital int
}

type ProjectHeap []Project

func (h ProjectHeap) Len() int           { return len(h) }
func (h ProjectHeap) Less(i, j int) bool { return h[i].profit > h[j].profit }
func (h ProjectHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *ProjectHeap) Push(x interface{}) {
	*h = append(*h, x.(Project))
}

func (h *ProjectHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func findMaximizedCapital(k int, w int, profits []int, capital []int) int {
	n := len(profits)
	projects := make([]Project, n)
	for i := 0; i < n; i++ {
		projects[i] = Project{profit: profits[i], capital: capital[i]}
	}

	sort.Slice(projects, func(i, j int) bool {
		return projects[i].capital < projects[j].capital
	})

	h := &ProjectHeap{}
	heap.Init(h)

	projectIndex := 0
	for i := 0; i < k; i++ {
		for projectIndex < n && projects[projectIndex].capital <= w {
			heap.Push(h, projects[projectIndex])
			projectIndex++
		}

		if h.Len() == 0 {
			break
		}

		bestProject := heap.Pop(h).(Project)
		w += bestProject.profit
	}

	return w
}