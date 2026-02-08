func minCost(home [][]int, start []int, target []int) int {
    m, n := len(home), len(home[0])
    directions := [][]int{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}
    cost := make([][]int, m)
    for i := range cost {
        cost[i] = make([]int, n)
        for j := range cost[i] {
            cost[i][j] = math.MaxInt32
        }
    }
    cost[start[0]][start[1]] = 0

    pq := &PriorityQueue{}
    heap.Push(pq, &Item{start[0], start[1], 0})

    for pq.Len() > 0 {
        current := heap.Pop(pq).(*Item)
        x, y, c := current.x, current.y, current.cost

        if x == target[0] && y == target[1] {
            return c
        }

        for _, d := range directions {
            nx, ny := x+d[0], y+d[1]
            if nx >= 0 && ny >= 0 && nx < m && ny < n {
                newCost := c + home[nx][ny]
                if newCost < cost[nx][ny] {
                    cost[nx][ny] = newCost
                    heap.Push(pq, &Item{nx, ny, newCost})
                }
            }
        }
    }

    return -1
}

type Item struct {
    x, y, cost int
}

type PriorityQueue []*Item

func (pq PriorityQueue) Len() int {
    return len(pq)
}

func (pq PriorityQueue) Less(i, j int) bool {
    return pq[i].cost < pq[j].cost
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
    *pq = old[0 : n-1]
    return item
}