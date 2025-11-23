import (
	"fmt"
)

func findMinStep(board string, hand string) int {
	handCount := make(map[rune]int)
	for _, c := range hand {
		handCount[c]++
	}

	var dfs func(string, map[rune]int) int
	dfs = func(board string, handCount map[rune]int) int {
		board = cleanBoard(board)
		if len(board) == 0 {
			return 0
		}

		minSteps := -1
		for i := 0; i < len(board); i++ {
			for c := range handCount {
				if handCount[c] == 0 {
					continue
				}

				if i > 0 && board[i-1] == byte(c) && board[i] == byte(c) {
					continue
				}

				if i+1 < len(board) && board[i+1] == byte(c) && board[i] == byte(c) {
					continue
				}

				if board[i] == byte(c) {
					newBoard := board[:i+1] + string(c) + board[i+1:]
					newHandCount := make(map[rune]int)
					for k, v := range handCount {
						newHandCount[k] = v
					}
					newHandCount[c]--

					steps := dfs(newBoard, newHandCount)
					if steps != -1 {
						if minSteps == -1 || steps+1 < minSteps {
							minSteps = steps + 1
						}
					}
				} else {
					newBoard := board[:i] + string(c) + board[i:]
					newHandCount := make(map[rune]int)
					for k, v := range handCount {
						newHandCount[k] = v
					}
					newHandCount[c]--

					steps := dfs(newBoard, newHandCount)
					if steps != -1 {
						if minSteps == -1 || steps+1 < minSteps {
							minSteps = steps + 1
						}
					}
				}
			}
		}
		return minSteps
	}

	return dfs(board, handCount)
}

func cleanBoard(board string) string {
	for {
		n := len(board)
		newBoard := ""
		i := 0
		for i < n {
			j := i
			for j < n && board[i] == board[j] {
				j++
			}
			if j-i >= 3 {
				i = j
			} else {
				newBoard += board[i:j]
				i = j
			}
		}
		if len(newBoard) == n {
			break
		}
		board = newBoard
	}
	return board
}