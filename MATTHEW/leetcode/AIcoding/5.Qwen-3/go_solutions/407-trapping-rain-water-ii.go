package main

func trapRainWater(heightMap [][]int) int {
	if len(heightMap) == 0 || len(heightMap[0]) == 0 {
		return 0
	}
	m, n := len(heightMap), len(heightMap[0])
	visited := make([][]bool, m)
	for i := range visited {
		visited[i] = make([]bool, n)
	}
	h := &Heap{}
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if i == 0 || i == m-1 || j == 0 || j == n-1 {
				heap.Push(h, []int{heightMap[i][j], i, j})
				visited[i][j] = true
			}
		}
	}
	dirs := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
	result := 0
	for h.Len() > 0 {
		curr := heap.Pop(h).([]int)
		for _, dir := range dirs {
			x, y := curr[1]+dir[0], curr[2]+dir[1]
			if x >= 0 && x < m && y >= 0 && y < n && !visited[x][y] {
				visited[x][y] = true
				if heightMap[x][y] < curr[0] {
					result += curr[0] - heightMap[x][y]
				}
				heap.Push(h, []int{max(curr[0], heightMap[x][y]), x, y})
			}
		}
	}
	return result
}

type Heap [][]int

func (h Heap) Len() int           { return len(h) }
func (h Heap) Less(i, j int) bool { return h[i][0] < h[j][0] }
func (h Heap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *Heap) Push(x interface{}) {
	*h = append(*h, x.([]int))
}

func (h *Heap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}