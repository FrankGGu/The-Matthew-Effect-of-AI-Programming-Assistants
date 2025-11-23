package main

import (
	"container/list"
	"fmt"
	"strings"
)

func slidingPuzzle(board [][]int) int {
	target := "123450"

	initialBoardStr := ""
	for i := 0; i < 2; i++ {
		for j := 0; j < 3; j++ {
			initialBoardStr += fmt.Sprintf("%d", board[i][j])
		}
	}

	if initialBoardStr == target {
		return 0
	}

	queue := list.New()
	visited := make(map[string]bool)

	queue.PushBack(state{boardStr: initialBoardStr, moves: 0})
	visited[initialBoardStr] = true

	swaps := [][]int{
		{1, 3},
		{0, 2, 4},
		{1, 5},
		{0, 4},
		{1, 3, 5},
		{2, 4},
	}

	for queue.Len() > 0 {
		e := queue.Front()
		queue.Remove(e)
		currState := e.Value.(state)

		zeroIdx := strings.Index(currState.boardStr, "0")

		for _, swapIdx := range swaps[zeroIdx] {
			nextBoardRunes := []rune(currState.boardStr)
			nextBoardRunes[zeroIdx], nextBoardRunes[swapIdx] = nextBoardRunes[swapIdx], nextBoardRunes[zeroIdx]
			nextStr := string(nextBoardRunes)

			if nextStr == target {
				return currState.moves + 1
			}

			if !visited[nextStr] {
				visited[nextStr] = true
				queue.PushBack(state{boardStr: nextStr, moves: currState.moves + 1})
			}
		}
	}

	return -1
}

type state struct {
	boardStr string
	moves    int
}