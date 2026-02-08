import "container/heap"

func kSimilarity(A string, B string) int {
    if A == B {
        return 0
    }

    n := len(A)
    visited := make(map[string]bool)
    queue := &PriorityQueue{}
    heap.Push(queue, &Item{A, 0})
    visited[A] = true

    for queue.Len() > 0 {
        item := heap.Pop(queue).(*Item)
        current, steps := item.str, item.steps

        if current == B {
            return steps
        }

        for i := 0; i < n; i++ {
            if current[i] != B[i] {
                for j := i + 1; j < n; j++ {
                    if current[j] == B[i] && current[j] != B[j] {
                        next := swap(current, i, j)
                        if !visited[next] {
                            visited[next] = true
                            heap.Push(queue, &Item{next, steps + 1})
                        }
                    }
                }
                break
            }
        }
    }

    return -1
}

func swap(s string, i, j int) string {
    runes := []rune(s)
    runes[i], runes[j] = runes[j], runes[i]
    return string(runes)
}

type Item struct {
    str   string
    steps int
}

type PriorityQueue []*Item

func (pq PriorityQueue) Len() int {
    return len(pq)
}

func (pq PriorityQueue) Less(i, j int) bool {
    return pq[i].steps < pq[j].steps
}

func (pq *PriorityQueue) Swap(i, j int) {
    pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
    *pq = append(*pq, x.(*Item))
}

func (pq *PriorityQueue) Pop() interface{} {
    old := *pq
    n := len(old)
    item := old[n-1]
    *pq = old[0 : n-1]
    return item
}