import "container/heap"

type Item struct {
	char  byte
	count int
}

type PriorityQueue []*Item

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].count > pq[j].count
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

func longestDiverseString(a int, b int, c int) string {
	pq := &PriorityQueue{}
	heap.Init(pq)

	if a > 0 {
		heap.Push(pq, &Item{char: 'a', count: a})
	}
	if b > 0 {
		heap.Push(pq, &Item{char: 'b', count: b})
	}
	if c > 0 {
		heap.Push(pq, &Item{char: 'c', count: c})
	}

	result := ""
	for pq.Len() > 0 {
		item := heap.Pop(pq).(*Item)
		if len(result) > 1 && result[len(result)-1] == item.char && result[len(result)-2] == item.char {
			if pq.Len() == 0 {
				break
			}
			item2 := heap.Pop(pq).(*Item)
			result += string(item2.char)
			item2.count--
			if item2.count > 0 {
				heap.Push(pq, item2)
			}
			heap.Push(pq, item)
		} else {
			result += string(item.char)
			item.count--
			if item.count > 0 {
				heap.Push(pq, item)
			}
		}
	}

	return result
}