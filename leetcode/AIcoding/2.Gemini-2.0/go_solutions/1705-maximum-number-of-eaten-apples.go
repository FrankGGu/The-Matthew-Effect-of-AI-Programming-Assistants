import "container/heap"

type Apple struct {
	RotDay int
	Amount int
}

type PriorityQueue []*Apple

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].RotDay < pq[j].RotDay
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	item := x.(*Apple)
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	old[n-1] = nil
	*pq = old[0 : n-1]
	return item
}

func eatenApples(apples []int, days []int) int {
	pq := &PriorityQueue{}
	heap.Init(pq)
	eaten := 0
	for i := 0; i < len(apples) || pq.Len() > 0; i++ {
		for pq.Len() > 0 && (*pq)[0].RotDay <= i {
			heap.Pop(pq)
		}
		if i < len(apples) && apples[i] > 0 {
			heap.Push(pq, &Apple{RotDay: i + days[i], Amount: apples[i]})
		}
		if pq.Len() > 0 {
			apple := heap.Pop(pq).(*Apple)
			apple.Amount--
			eaten++
			if apple.Amount > 0 && apple.RotDay > i+1 {
				heap.Push(pq, apple)
			}
		}
	}
	return eaten
}