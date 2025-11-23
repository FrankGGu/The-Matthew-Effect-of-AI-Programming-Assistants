import "container/heap"

type State struct {
	node int
	cost int
	time int
}

type PriorityQueue []State

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].cost < pq[j].cost
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

func minCost(maxTime int, costs []int, flights [][]int) int {
	n := len(costs)
	adj := make([][]int, n)
	adjCost := make([][]int, n)
	adjTime := make([][]int, n)

	for _, flight := range flights {
		u, v, time := flight[0], flight[1], flight[2]
		adj[u-1] = append(adj[u-1], v-1)
		adjCost[u-1] = append(adjCost[u-1], costs[v-1])
		adjTime[u-1] = append(adjTime[u-1], time)

		adj[v-1] = append(adj[v-1], u-1)
		adjCost[v-1] = append(adjCost[v-1], costs[u-1])
		adjTime[v-1] = append(adjTime[v-1], time)
	}

	minCosts := make([][]int, n)
	for i := range minCosts {
		minCosts[i] = make([]int, maxTime+1)
		for j := range minCosts[i] {
			minCosts[i][j] = 1000000000 // Infinity
		}
	}

	pq := &PriorityQueue{}
	heap.Init(pq)
	heap.Push(pq, State{node: 0, cost: costs[0], time: 0})
	minCosts[0][0] = costs[0]

	for pq.Len() > 0 {
		curr := heap.Pop(pq).(State)
		u, cost, time := curr.node, curr.cost, curr.time

		if cost > minCosts[u][time] {
			continue
		}

		if u == n-1 {
			continue
		}

		for i, v := range adj[u] {
			newTime := time + adjTime[u][i]
			newCost := cost + adjCost[u][i]

			if newTime <= maxTime && newCost < minCosts[v][newTime] {
				minCosts[v][newTime] = newCost
				heap.Push(pq, State{node: v, cost: newCost, time: newTime})
			}
		}
	}

	ans := 1000000000
	for time := 0; time <= maxTime; time++ {
		ans = min(ans, minCosts[n-1][time])
	}

	if ans >= 1000000000 {
		return -1
	}
	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}