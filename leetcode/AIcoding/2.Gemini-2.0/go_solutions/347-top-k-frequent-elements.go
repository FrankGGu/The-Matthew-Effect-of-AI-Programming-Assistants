import (
	"container/heap"
)

type Item struct {
	Value string
	Count int
}

type PriorityQueue []*Item

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].Count < pq[j].Count
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	item := x.(*Item)
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func topKFrequent(nums []int, k int) []int {
	counts := make(map[int]int)
	for _, num := range nums {
		counts[num]++
	}

	pq := make(PriorityQueue, 0)
	heap.Init(&pq)

	for num, count := range counts {
		heap.Push(&pq, &Item{Value: string(rune(num)), Count: count})
		if pq.Len() > k {
			heap.Pop(&pq)
		}
	}

	result := make([]int, k)
	for i := k - 1; i >= 0; i-- {
		item := heap.Pop(&pq).(*Item)
		result[i] = int([]rune(item.Value)[0])
	}

	return result
}