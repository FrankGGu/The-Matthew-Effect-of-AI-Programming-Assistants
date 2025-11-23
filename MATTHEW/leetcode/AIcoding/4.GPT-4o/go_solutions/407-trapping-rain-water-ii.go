func trapRainWater(height [][]int) int {
    if len(height) == 0 || len(height[0]) == 0 {
        return 0
    }

    n, m := len(height), len(height[0])
    water := 0
    maxHeap := &PriorityQueue{}
    visited := make([][]bool, n)

    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            visited[i] = append(visited[i], false)
        }
    }

    for i := 0; i < n; i++ {
        heap.Push(maxHeap, &Cell{height: height[i][0], x: i, y: 0})
        heap.Push(maxHeap, &Cell{height: height[i][m-1], x: i, y: m - 1})
        visited[i][0], visited[i][m-1] = true, true
    }

    for j := 0; j < m; j++ {
        heap.Push(maxHeap, &Cell{height: height[0][j], x: 0, y: j})
        heap.Push(maxHeap, &Cell{height: height[n-1][j], x: n - 1, y: j})
        visited[0][j], visited[n-1][j] = true, true
    }

    directions := [][2]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}

    for maxHeap.Len() > 0 {
        cell := heap.Pop(maxHeap).(*Cell)
        for _, dir := range directions {
            nx, ny := cell.x + dir[0], cell.y + dir[1]
            if nx >= 0 && nx < n && ny >= 0 && ny < m && !visited[nx][ny] {
                visited[nx][ny] = true
               	if height[nx][ny] < cell.height {
                    water += cell.height - height[nx][ny]
                }
                heap.Push(maxHeap, &Cell{height: max(cell.height, height[nx][ny]), x: nx, y: ny})
            }
        }
    }

    return water
}

type Cell struct {
    height int
    x      int
    y      int
}

type PriorityQueue []*Cell

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool { return pq[i].height > pq[j].height }

func (pq PriorityQueue) Swap(i, j int) { pq[i], pq[j] = pq[j], pq[i] }

func (pq *PriorityQueue) Push(x interface{}) {
    *pq = append(*pq, x.(*Cell))
}

func (pq *PriorityQueue) Pop() interface{} {
    old := *pq
    n := len(old)
    x := old[n-1]
    *pq = old[0 : n-1]
    return x
}