type Item struct {
	val int
	idx int
}

type PriorityQueue []*Item

func (pq PriorityQueue) Len() int { return len(pq)