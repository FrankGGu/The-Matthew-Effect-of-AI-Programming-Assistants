package main

type Edge struct {
    node int
    time int
}

func reachableNodes(nums [][]int, k int) int {
    graph := make(map[int][]Edge)
    for _, edge := range nums {
        u, v, w := edge[0], edge[1], edge[2]
        graph[u] = append(graph[u], Edge{v, w})
        graph[v] = append(graph[v], Edge{u, w})
    }

    heap := &PriorityQueue{}
    heap.Push(&Item{node: 0, dist: 0})
    visited := make(map[int]int)

    for heap.Len() > 0 {
        item := heap.Pop()
        node, dist := item.node, item.dist
        if dist > k {
            continue
        }
        if v, ok := visited[node]; ok && v <= dist {
            continue
        }
        visited[node] = dist
        for _, e := range graph[node] {
            if dist+e.time <= k {
                heap.Push(&Item{node: e.node, dist: dist + e.time})
            }
        }
    }

    count := 0
    for node, dist := range visited {
        count++
        for _, e := range graph[node] {
            if dist+e.time <= k {
                count++
            }
        }
    }

    return count
}

type Item struct {
    node int
    dist int
}

type PriorityQueue []*Item

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
    return pq[i].dist < pq[j].dist
}

func (pq PriorityQueue) Swap(i, j int) {
    pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
    *pq = append(*pq, x.(*Item))
}

func (pq *PriorityQueue) Pop() interface{} {
    old := *pq
    n := len(old)
    item := old[n-1]
    old[n-1] = nil
    *pq = old[0 : n-1]
    return item
}