import "container/heap"

func kSimilarity(s1 string, s2 string) int {
	if s1 == s2 {
		return 0
	}

	n := len(s1)
	queue := []string{s1}
	visited := map[string]bool{s1: true}
	steps := 0

	for len(queue) > 0 {
		size := len(queue)
		for i := 0; i < size; i++ {
			curr := queue[0]
			queue = queue[1:]

			if curr == s2 {
				return steps
			}

			for j := 0; j < n; j++ {
				if curr[j] != s2[j] {
					for k := j + 1; k < n; k++ {
						if curr[k] == s2[j] && curr[k] != s2[k] {
							next := swap(curr, j, k)
							if !visited[next] {
								visited[next] = true
								queue = append(queue, next)
							}
						}
					}
					break
				}
			}
		}
		steps++
	}

	return -1
}

func swap(s string, i, j int) string {
	runes := []rune(s)
	runes[i], runes[j] = runes[j], runes[i]
	return string(runes)
}

type State struct {
	Str   string
	Steps int
}

type PriorityQueue []State

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].Steps < pq[j].Steps
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	item := x.(State)
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func kSimilarityAStar(s1 string, s2 string) int {
	if s1 == s2 {
		return 0
	}

	n := len(s1)
	pq := &PriorityQueue{State{s1, 0}}
	heap.Init(pq)
	visited := map[string]bool{s1: true}

	for pq.Len() > 0 {
		currState := heap.Pop(pq).(State)
		curr := currState.Str
		steps := currState.Steps

		if curr == s2 {
			return steps
		}

		for j := 0; j < n; j++ {
			if curr[j] != s2[j] {
				for k := j + 1; k < n; k++ {
					if curr[k] == s2[j] {
						next := swap(curr, j, k)
						if !visited[next] {
							visited[next] = true
							priority := steps + 1 + heuristic(next, s2)
							heap.Push(pq, State{next, steps + 1})
						}
					}
				}
				break
			}
		}
	}

	return -1
}

func heuristic(s1 string, s2 string) int {
	diff := 0
	for i := 0; i < len(s1); i++ {
		if s1[i] != s2[i] {
			diff++
		}
	}
	return diff
}