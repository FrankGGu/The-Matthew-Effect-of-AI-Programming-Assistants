func minimumObstacles(grid [][]int) int {
    rows, cols := len(grid), len(grid[0])
    directions := [][2]int{{1, 0}, {0, 1}, {-1, 0}, {0, -1}}
    dist := make([][]int, rows)
    for i := range dist {
        dist[i] = make([]int, cols)
        for j := range dist[i] {
            dist[i][j] = 1 << 31 - 1
        }
    }
    dist[0][0] = 0
    pq := &PriorityQueue{}
    heap.Push(pq, &Node{0, 0, 0})

    for pq.Len() > 0 {
        cur := heap.Pop(pq).(*Node)
        x, y, d := cur.x, cur.y, cur.dist
        if x == rows-1 && y == cols-1 {
            return d
        }
        for _, dir := range directions {
            nx, ny := x + dir[0], y + dir[1]
            if nx >= 0 && nx < rows && ny >= 0 && ny < cols {
                newDist := d + grid[nx][ny]
                if newDist < dist[nx][ny] {
                    dist[nx][ny] = newDist
                    heap.Push(pq, &Node{nx, ny, newDist})
                }
            }
        }
    }
    return -1
}

type Node struct {
    x, y, dist int
}

type PriorityQueue []*Node

func (pq PriorityQueue) Len() int {
    return len(pq)
}

func (pq PriorityQueue) Less(i, j int) bool {
    return pq[i].dist < pq[j].dist
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
    item := old[n-1]
    *pq = old[0 : n-1]
    return item
}