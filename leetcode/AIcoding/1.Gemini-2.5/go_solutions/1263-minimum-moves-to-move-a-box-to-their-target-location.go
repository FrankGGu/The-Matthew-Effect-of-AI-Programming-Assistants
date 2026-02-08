package main

import (
	"container/list"
)

type State struct {
	boxR, boxC int
	playerR, playerC int
	pushes int
}

type PlayerPos struct {
	r, c int
}

var (
	dr = []int{-1, 1, 0, 0}
	dc = []int{0, 0, -1, 1}
)

func minPushBox(grid []string) int {
	m := len(grid)
	n := len(grid[0])

	var startBoxR, startBoxC, startPlayerR, startPlayerC int
	var targetR, targetC int

	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			if grid[r][c] == 'B' {
				startBoxR, startBoxC = r, c
			} else if grid[r][c] == 'S' {
				startPlayerR, startPlayerC = r, c
			} else if grid[r][c] == 'T' {
				targetR, targetC = r, c
			}
		}
	}

	queue := list.New()
	queue.PushBack(State{startBoxR, startBoxC, startPlayerR, startPlayerC, 0})

	visited := make([][][][]bool, m)
	for i := range visited {
		visited[i] = make([][][]bool, n)
		for j := range visited[i] {
			visited[i][j] = make([][]bool, m)
			for k := range visited[i][j] {
				visited[i][j][k] = make([]bool, n)
			}
		}
	}
	visited[startBoxR][startBoxC][startPlayerR][startPlayerC] = true

	for queue.Len() > 0 {
		e := queue.Front()
		queue.Remove(e)
		curr := e.Value.(State)

		if curr.boxR == targetR && curr.boxC == targetC {
			return curr.pushes
		}

		for i := 0; i < 4; i++ {
			newBoxR, newBoxC := curr.boxR + dr[i], curr.boxC + dc[i]
			playerPushFromR, playerPushFromC := curr.boxR - dr[i], curr.boxC - dc[i]

			if newBoxR < 0 || newBoxR >= m || newBoxC < 0 || newBoxC >= n || grid[newBoxR][newBoxC] == '#' {
				continue
			}
			if playerPushFromR < 0 || playerPushFromR >= m || playerPushFromC < 0 || playerPushFromC >= n || grid[playerPushFromR][playerPushFromC] == '#' {
				continue
			}

			if canPlayerReach(grid, curr.playerR, curr.playerC, playerPushFromR, playerPushFromC, curr.boxR, curr.boxC) {
				if !visited[newBoxR][newBoxC][curr.boxR][curr.boxC] {
					visited[newBoxR][newBoxC][curr.boxR][curr.boxC] = true
					queue.PushBack(State{newBoxR, newBoxC, curr.boxR, curr.boxC, curr.pushes + 1})
				}
			}
		}
	}

	return -1
}

func canPlayerReach(grid []string, startR, startC, targetR, targetC, boxR, boxC int) bool {
	m := len(grid)
	n := len(grid[0])

	playerQueue := list.New()
	playerQueue.PushBack(PlayerPos{startR, startC})

	visitedPlayer := make([][]bool, m)
	for i := range visitedPlayer {
		visitedPlayer[i] = make([]bool, n)
	}
	visitedPlayer[startR][startC] = true

	for playerQueue.Len() > 0 {
		e := playerQueue.Front()
		playerQueue.Remove(e)
		curr := e.Value.(PlayerPos)

		if curr.r == targetR && curr.c == targetC {
			return true
		}

		for i := 0; i < 4; i++ {
			nextR, nextC := curr.r + dr[i], curr.c + dc[i]

			if nextR < 0 || nextR >= m || nextC < 0 || nextC >= n || grid[nextR][nextC] == '#' {
				continue
			}
			if nextR == boxR && nextC == boxC {
				continue
			}
			if !visitedPlayer[nextR][nextC] {
				visitedPlayer[nextR][nextC] = true
				playerQueue.PushBack(PlayerPos{nextR, nextC})
			}
		}
	}
	return false
}