type Item struct {
	x, y, cost int
}

func minCost(grid [][]int) int {
	m, n := len(grid), len(grid[0])
	directions := [][2]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
	costs := make([][]int, m)
	for i := range costs {
		costs[i] = make([]int, n)
		for j := range costs[i] {
			costs[i][j] = math.MaxInt32
		}
	}
	costs[0][0] = 0

	pq := &[]Item{{0, 0, 0}}
	heap.Init(pq)

	for pq.Len() > 0 {
		cur := heap.Pop(pq).(Item)
		x, y, cost := cur.x, cur.y, cur.cost
		if x == m-1 && y == n-1 {
			return cost
		}
		for i, d := range directions {
			nx, ny := x+d[0], y+d[1]
			if nx >= 0 && nx < m && ny >= 0 && ny < n {
				newCost := cost + 1
				if i+1 != grid[x][y] {
					newCost--
				}
				if newCost < costs[nx][ny] {
					costs[nx][ny] = newCost
					heap.Push(pq, Item{nx, ny, newCost})
				}
			}
		}
	}
	return -1
}