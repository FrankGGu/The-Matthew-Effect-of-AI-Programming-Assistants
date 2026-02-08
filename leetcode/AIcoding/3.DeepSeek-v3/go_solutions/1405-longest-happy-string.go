func longestDiverseString(a int, b int, c int) string {
    res := make([]byte, 0)
    pq := &PriorityQueue{}
    heap.Init(pq)
    if a > 0 {
        heap.Push(pq, &CharCount{'a', a})
    }
    if b > 0 {
        heap.Push(pq, &CharCount{'b', b})
    }
    if c > 0 {
        heap.Push(pq, &CharCount{'c', c})
    }

    for pq.Len() > 0 {
        first := heap.Pop(pq).(*CharCount)
        n := len(res)
        if n >= 2 && res[n-1] == first.char && res[n-2] == first.char {
            if pq.Len() == 0 {
                break
            }
            second := heap.Pop(pq).(*CharCount)
            res = append(res, second.char)
            second.count--
            if second.count > 0 {
                heap.Push(pq, second)
            }
            heap.Push(pq, first)
        } else {
            res = append(res, first.char)
            first.count--
            if first.count > 0 {
                heap.Push(pq, first)
            }
        }
    }
    return string(res)
}

type CharCount struct {
    char  byte
    count int
}

type PriorityQueue []*CharCount

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
    return pq[i].count > pq[j].count
}

func (pq PriorityQueue) Swap(i, j int) {
    pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
    item := x.(*CharCount)
    *pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
    old := *pq
    n := len(old)
    item := old[n-1]
    *pq = old[0 : n-1]
    return item
}