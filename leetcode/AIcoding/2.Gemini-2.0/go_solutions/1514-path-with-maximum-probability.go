import (
	"container/heap"
)

type Edge struct {
	To    int
	Prob  float64
}

type Node struct {
	Node  int
	Prob  float64
}

type PriorityQueue []Node

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].Prob > pq[j].Prob
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	item := x.(Node)
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func maxProbability(n int, edges [][]int, succProb []float64, start int, end int) float64 {
	adj := make([][]Edge, n)
	for i := 0; i < len(edges); i++ {
		adj[edges[i][0]] = append(adj[edges[i][0]], Edge{To: edges[i][1], Prob: succProb[i]})
		adj[edges[i][1]] = append(adj[edges[i][1]], Edge{To: edges[i][0], Prob: succProb[i]})
	}

	probabilities := make([]float64, n)
	probabilities[start] = 1.0

	pq := &PriorityQueue{}
	heap.Init(pq)
	heap.Push(pq, Node{Node: start, Prob: 1.0})

	for pq.Len() > 0 {
		curr := heap.Pop(pq).(Node)
		node := curr.Node
		prob := curr.Prob

		if prob < probabilities[node] {
			continue
		}

		for _, edge := range adj[node] {
			neighbor := edge.To
			newProb := prob * edge.Prob
			if newProb > probabilities[neighbor] {
				probabilities[neighbor] = newProb
				heap.Push(pq, Node{Node: neighbor, Prob: newProb})
			}
		}
	}

	return probabilities[end]
}