type Node struct {
    ID       int
    Time     int
    Disappear int
}

func minimumTime(n int, edges [][]int, time []int, change []int) int {
    graph := make([][]int, n)
    for _, edge := range edges {
        graph[edge[0]] = append(graph[edge[0]], edge[1])
        graph[edge[1]] = append(graph[edge[1]], edge[0])
    }

    dist := make([]int, n)
    for i := range dist {
        dist[i] = math.MaxInt32
    }
    dist[0] = 0

    pq := &PriorityQueue{}
    heap.Push(pq, &Node{ID: 0, Time: 0})

    for pq.Len() > 0 {
        node := heap.Pop(pq).(*Node)
        currID := node.ID
        currTime := node.Time

        if currID == n-1 {
            return currTime
        }

        for _, neighbor := range graph[currID] {
            newTime := currTime + time[currID]
            cycle := change[currID] * 2
            waitTime := newTime % cycle

            if waitTime < change[currID] {
                newTime += change[currID] - waitTime
            } else if waitTime >= change[currID] {
                newTime += cycle - waitTime
            }

            if newTime < dist[neighbor] {
                dist[neighbor] = newTime
                heap.Push(pq, &Node{ID: neighbor, Time: newTime})
            }
        }
    }

    return -1
}

type PriorityQueue []*Node

func (pq PriorityQueue) Len() int { return len(pq) }
func (pq PriorityQueue) Less(i, j int) bool {
    return pq[i].Time < pq[j].Time
}
func (pq PriorityQueue) Swap(i, j int) {
    pq[i], pq[j] = pq[j], pq[i]
}
func (pq *PriorityQueue) Push(x interface{}) {
    *pq = append(*pq, x.(*Node))
}
func (pq *PriorityQueue) Pop() interface{} {
    old := *pq
    n := len(old)
    x := old[n-1]
    *pq = old[0 : n-1]
    return x
}