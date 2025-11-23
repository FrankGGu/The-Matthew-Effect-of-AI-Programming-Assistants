import "container/list"

func slidingPuzzle(board [][]int) int {
	start := ""
	for i := 0; i < 2; i++ {
		for j := 0; j < 3; j++ {
			start += string(rune(board[i][j] + '0'))
		}
	}

	target := "123450"
	if start == target {
		return 0
	}

	neighbors := [][]int{{1, 3}, {0, 2, 4}, {1, 5}, {0, 4}, {1, 3, 5}, {2, 4}}
	visited := make(map[string]bool)
	queue := list.New()
	queue.PushBack(start)
	visited[start] = true
	moves := 0

	for queue.Len() > 0 {
		moves++
		size := queue.Len()
		for i := 0; i < size; i++ {
			curr := queue.Front().Value.(string)
			queue.Remove(queue.Front())

			zeroIndex := -1
			for j := 0; j < 6; j++ {
				if curr[j] == '0' {
					zeroIndex = j
					break
				}
			}

			for _, neighbor := range neighbors[zeroIndex] {
				next := []rune(curr)
				next[zeroIndex], next[neighbor] = next[neighbor], next[zeroIndex]
				nextStr := string(next)

				if nextStr == target {
					return moves
				}

				if !visited[nextStr] {
					queue.PushBack(nextStr)
					visited[nextStr] = true
				}
			}
		}
	}

	return -1
}