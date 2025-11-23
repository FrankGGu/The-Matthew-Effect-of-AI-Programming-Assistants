package main

func canVisitAllRooms(rooms [][]int) bool {
	visited := make([]bool, len(rooms))
	var dfs func(int)
	dfs = func(n int) {
		if visited[n] {
			return
		}
		visited[n] = true
		for _, key := range rooms[n] {
			dfs(key)
		}
	}
	dfs(0)
	for _, v := range visited {
		if !v {
			return false
		}
	}
	return true
}