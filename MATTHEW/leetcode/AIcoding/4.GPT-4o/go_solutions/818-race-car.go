package main

import "container/heap"

type State struct {
	pos  int
	speed int
}

type PriorityQueue []*State

func (pq PriorityQueue) Len() int {
	return len(pq)
}

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].pos+pq[i].speed < pq[j].pos+pq[j].speed
}

func (pq *PriorityQueue) Push(x interface{}) {
	*pq = append(*pq, x.(*State))
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	x := old[n-1]
	*pq = old[0 : n-1]
	return x
}

func racecar(target int) int {
	target = abs(target)
	pq := &PriorityQueue{}
	heap.Init(pq)
	heap.Push(pq, &State{0, 1})
	visited := map[[2]int]bool{}
	visited[[2]int{0, 1}] = true
	steps := 0

	for pq.Len() > 0 {
		for i := pq.Len(); i > 0; i-- {
			current := heap.Pop(pq).(*State)
			pos, speed := current.pos, current.speed

			if pos == target {
				return steps
			}

			nextPos := pos + speed
			nextSpeed := speed * 2
			if nextPos >= 0 && nextPos < 2*target && !visited[[2]int{nextPos, nextSpeed}] {
				visited[[2]int{nextPos, nextSpeed}] = true
				heap.Push(pq, &State{nextPos, nextSpeed})
			}

			nextSpeed = -1
			if speed > 0 {
				nextSpeed = -1
			} else {
				nextSpeed = 1
			}
			if pos > 0 && pos < 2*target && !visited[[2]int{pos, nextSpeed}] {
				visited[[2]int{pos, nextSpeed}] = true
				heap.Push(pq, &State{pos, nextSpeed})
			}
		}
		steps++
	}
	return -1
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}