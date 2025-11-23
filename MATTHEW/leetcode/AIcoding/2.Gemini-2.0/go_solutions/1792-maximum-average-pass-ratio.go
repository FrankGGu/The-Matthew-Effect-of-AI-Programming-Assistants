import (
	"container/heap"
)

type Class struct {
	pass   int
	total  int
	diff   float64
}

type PriorityQueue []*Class

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].diff > pq[j].diff
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	item := x.(*Class)
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func maxAverageRatio(classes [][]int, extraStudents int) float64 {
	pq := &PriorityQueue{}
	heap.Init(pq)

	for _, c := range classes {
		pass := c[0]
		total := c[1]
		diff := float64(pass+1)/float64(total+1) - float64(pass)/float64(total)
		heap.Push(pq, &Class{pass, total, diff})
	}

	for i := 0; i < extraStudents; i++ {
		c := heap.Pop(pq).(*Class)
		c.pass++
		c.total++
		c.diff = float64(c.pass+1)/float64(c.total+1) - float64(c.pass)/float64(c.total)
		heap.Push(pq, c)
	}

	sum := 0.0
	for i := 0; i < len(classes); i++ {
		c := heap.Pop(pq).(*Class)
		sum += float64(c.pass) / float64(c.total)
	}

	return sum / float64(len(classes))
}