package main

import (
	"container/heap"
)

type Pair struct {
	port, time int
}

type MinHeap []Pair

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].time < h[j].time }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(Pair))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func boxDelivering(boxes [][]int, portsCount int, maxBoxes int, maxWeight int) int {
	n := len(boxes)
	dp := make([]int, n+1)
	for i := range dp {
		dp[i] = n + 1
	}
	dp[0] = 0

	h := &MinHeap{}
	heap.Init(h)

	for i := 0; i < n; i++ {
		for j := i; j >= 0 && j >= i-maxBoxes+1; j-- {
			if j > 0 && boxes[j-1][1] > maxWeight {
				break
			}
			if j == 0 || boxes[j-1][1]+boxes[i][1] <= maxWeight {
				heap.Push(h, Pair{box: j, time: dp[j] + 1})
			}
		}
		for h.Len() > 0 && h.Top().port < i-maxBoxes+1 {
			heap.Pop(h)
		}
		if h.Len() > 0 {
			dp[i+1] = h.Top().time
		}
	}

	return dp[n]
}

func main() {
	// Example usage:
	// boxes := [][]int{{1, 2}, {2, 1}, {3, 3}, {1, 1}}
	// portsCount := 3
	// maxBoxes := 3
	// maxWeight := 6
	// result := boxDelivering(boxes, portsCount, maxBoxes, maxWeight)
	// fmt.Println(result)
}