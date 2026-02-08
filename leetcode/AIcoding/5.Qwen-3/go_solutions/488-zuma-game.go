package main

func findMinSteps(board string, hand string) int {
	type State struct {
		board  string
		hand   string
		steps  int
	}

	visited := make(map[string]bool)

	queue := []State{{board, hand, 0}}

	for len(queue) > 0 {
		state := queue[0]
		queue = queue[1:]

		if state.board == "" {
			return state.steps
		}

		if visited[state.board+","+state.hand] {
			continue
		}
		visited[state.board+","+state.hand] = true

		for i := 0; i < len(state.hand); i++ {
			newHand := state.hand[:i] + state.hand[i+1:]
			for j := 0; j <= len(state.board); j++ {
				newBoard := state.board[:j] + string(state.hand[i]) + state.board[j:]
				merged := merge(newBoard)
				queue = append(queue, State{merged, newHand, state.steps + 1})
			}
		}
	}

	return -1
}

func merge(s string) string {
	for i := 0; i < len(s); {
		j := i
		for j < len(s) && s[j] == s[i] {
			j++
		}
		if j-i >= 3 {
			return merge(s[:i] + s[j:])
		}
		i = j
	}
	return s
}