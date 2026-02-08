package main

func maxPoints(grid [][]int, queries []int) []int {
    m, n := len(grid), len(grid[0])
    points := make([]int, len(queries))
    sortedQueries := make([]int, len(queries))
    copy(sortedQueries, queries)
    sort.Ints(sortedQueries)

    visited := make([][]bool, m)
    for i := range visited {
        visited[i] = make([]bool, n)
    }

    pq := &PriorityQueue{}
    heap.Init(pq)

    for i := range grid {
        for j := range grid[i] {
            if grid[i][j] < sortedQueries[0] {
                pq.Push(&Item{value: grid[i][j], i: i, j: j})
                visited[i][j] = true
            }
        }
    }

    idx := 0
    for _, q := range sortedQueries {
        for pq.Len() > 0 && pq.Peek().value < q {
            item := heap.Pop(pq).(*Item)
            for _, dir := range [4][2]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}} {
                ni, nj := item.i+dir[0], item.j+dir[1]
                if ni >= 0 && ni < m && nj >= 0 && nj < n && !visited[ni][nj] && grid[ni][nj] < q {
                    visited[ni][nj] = true
                    heap.Push(pq, &Item{value: grid[ni][nj], i: ni, j: nj})
                }
            }
        }
        points[idx] = pq.Len()
        idx++
    }

    result := make([]int, len(queries))
    for i, q := range queries {
        for j, sq := range sortedQueries {
            if q == sq {
                result[i] = points[j]
                break
            }
        }
    }

    return result
}

type Item struct {
    value int
    i     int
    j     int
}

type PriorityQueue []*Item

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
    return pq[i].value < pq[j].value
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
    *pq = old[:n-1]
    return item
}

func (pq PriorityQueue) Peek() *Item {
    if pq.Len() == 0 {
        return nil
    }
    return pq[0]
}