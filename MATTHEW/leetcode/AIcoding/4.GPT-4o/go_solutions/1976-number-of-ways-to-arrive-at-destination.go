import "container/heap"

type Edge struct {
    to, time int
}

type PriorityQueue []Edge

func (pq PriorityQueue) Len() int {
    return len(pq)
}

func (pq PriorityQueue) Less(i, j int) bool {
    return pq[i].time < pq[j].time
}

func (pq *PriorityQueue) Push(x interface{}) {
    *pq = append(*pq, x.(Edge))
}

func (pq *PriorityQueue) Pop() interface{} {
    old := *pq
    n := len(old)
    x := old[n-1]
    *pq = old[0 : n-1]
    return x
}

func countPaths(n int, roads [][]int) int {
    mod := 1_000_000_007
    graph := make([][]Edge, n)
    for _, road := range roads {
        graph[road[0]] = append(graph[road[0]], Edge{road[1], road[2]})
        graph[road[1]] = append(graph[road[1]], Edge{road[0], road[2]})
    }

    dist := make([]int, n)
    ways := make([]int, n)
    for i := range dist {
        dist[i] = 1 << 60
    }
    dist[0] = 0
    ways[0] = 1

    pq := &PriorityQueue{{0, 0}}
    heap.Init(pq)

    for pq.Len() > 0 {
        current := heap.Pop(pq).(Edge)
        currNode, currDist := current.to, current.time

        if currDist > dist[currNode] {
            continue
        }

        for _, neighbor := range graph[currNode] {
            newDist := currDist + neighbor.time
            if newDist < dist[neighbor.to] {
                dist[neighbor.to] = newDist
                ways[neighbor.to] = ways[currNode]
                heap.Push(pq, Edge{neighbor.to, newDist})
            } else if newDist == dist[neighbor.to] {
                ways[neighbor.to] = (ways[neighbor.to] + ways[currNode]) % mod
            }
        }
    }

    return ways[n-1]
}