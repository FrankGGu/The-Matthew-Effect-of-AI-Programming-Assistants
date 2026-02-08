import "container/heap"

func shortestSubarray(A []int, K int) int {
    n := len(A)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] + A[i]
    }

    minLength := n + 1
    pq := &PriorityQueue{}
    heap.Init(pq)

    for i := 0; i <= n; i++ {
        for pq.Len() > 0 && prefix[i]-(*pq)[0] >= K {
            minLength = min(minLength, i-heap.Pop(pq).(int))
        }
        heap.Push(pq, prefix[i])
    }

    if minLength == n+1 {
        return -1
    }
    return minLength
}

type PriorityQueue []int

func (pq PriorityQueue) Len() int { return len(pq) }
func (pq PriorityQueue) Less(i, j int) bool { return pq[i] < pq[j] }
func (pq PriorityQueue) Swap(i, j int) { pq[i], pq[j] = pq[j], pq[i] }

func (pq *PriorityQueue) Push(x interface{}) {
    *pq = append(*pq, x.(int))
}

func (pq *PriorityQueue) Pop() interface{} {
    old := *pq
    n := len(old)
    x := old[n-1]
    *pq = old[0 : n-1]
    return x
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}