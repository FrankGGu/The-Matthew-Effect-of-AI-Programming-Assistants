import "container/heap"

type Item struct {
    x, y, time int
}

type PriorityQueue []Item

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
    return pq[i].time < pq[j].time
}

func (pq PriorityQueue) Swap(i, j int) {
    pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
    item := x.(Item)
    *pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
    old := *pq
    n := len(old)
    item := old[n-1]
    *pq = old[0 : n-1]
    return item
}

func minimumTime(grid [][]int) int {
    if grid[0][1] > 1 && grid[1][0] > 1 {
        return -1
    }

    m, n := len(grid), len(grid[0])
    dist := make([][]int, m)
    for i := range dist {
        dist[i] = make([]int, n)
        for j := range dist[i] {
            dist[i][j] = 1e9
        }
    }

    dist[0][0] = 0
    pq := &PriorityQueue{{0, 0, 0}}
    heap.Init(pq)

    dirs := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}

    for pq.Len() > 0 {
        curr := heap.Pop(pq).(Item)
        x, y, time := curr.x, curr.y, curr.time

        if x == m-1 && y == n-1 {
            return time
        }

        if time > dist[x][y] {
            continue
        }

        for _, dir := range dirs {
            nx, ny := x+dir[0], y+dir[1]
            if nx >= 0 && nx < m && ny >= 0 && ny < n {
                waitTime := 0
                if grid[nx][ny] > time+1 {
                    waitTime = grid[nx][ny] - (time + 1)
                    waitTime = (waitTime+1)/1 * 1
                }
                newTime := time + 1 + waitTime
                if newTime < dist[nx][ny] {
                    dist[nx][ny] = newTime
                    heap.Push(pq, Item{nx, ny, newTime})
                }
            }
        }
    }

    return -1
}