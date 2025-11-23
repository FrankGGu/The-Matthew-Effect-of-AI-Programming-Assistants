package main

import (
	"container/heap"
	"fmt"
)

type State struct {
	position string
	steps    int
}

type MinHeap []State

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].steps < h[j].steps }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(State))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func openLock(deadends []string, target string) int {
	dead := make(map[string]struct{})
	for _, d := range deadends {
		dead[d] = struct{}{}
	}

	if _, ok := dead["0000"]; ok {
		return -1
	}
	if target == "0000" {
		return 0
	}

	h := &MinHeap{}
	heap.Init(h)
	heap.Push(h, State{"0000", 0})
	visited := make(map[string]struct{})
	visited["0000"] = struct{}{}

	for h.Len() > 0 {
		curr := heap.Pop(h).(State)
		if curr.position == target {
			return curr.steps
		}

		for i := 0; i < 4; i++ {
			for j := -1; j <= 1; j += 2 {
				next := curr.position[:i] + string((int(curr.position[i]-'0')+j+10)%10+'0') + curr.position[i+1:]
				if _, ok := dead[next]; !ok {
					if _, visited := visited[next]; !visited {
						visited[next] = struct{}{}
						heap.Push(h, State{next, curr.steps + 1})
					}
				}
			}
		}
	}
	return -1
}

func main() {
	deadends := []string{"0201", "0101", "0102", "1212", "2002"}
	target := "0202"
	result := openLock(deadends, target)
	fmt.Println(result)
}