package main

import (
	"container/heap"
	"strings"
)

type Pair struct {
	char byte
	freq int
}

type MaxHeap []*Pair

func (h MaxHeap) Len() int { return len(h) }
func (h MaxHeap) Less(i, j int) bool {
	return h[i].freq > h[j].freq // Max-heap based on frequency
}
func (h MaxHeap) Swap(i, j int) { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
	*h = append(*h, x.(*Pair))
}

func (h *MaxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func reorganizeString(S string) string {
	n := len(S)
	if n <= 1 {
		return S
	}

	counts := make(map[byte]int)
	maxFreq := 0
	for i := 0; i < n; i++ {
		counts[S[i]]++
		if counts[S[i]] > maxFreq {
			maxFreq = counts[S[i]]
		}
	}

	if maxFreq > (n+1)/2 {
		return ""
	}

	h := &MaxHeap{}
	heap.Init(h)

	for char, freq := range counts {
		heap.Push(h, &Pair{char: char, freq: freq})
	}

	var result strings.Builder
	for h.Len() >= 2 {
		p1 := heap.Pop(h).(*Pair)
		p2 := heap.Pop(h).(*Pair)

		result.WriteByte(p1.char)
		result.WriteByte(p2.char)

		p1.freq--
		p2.freq--

		if p1.freq > 0 {
			heap.Push(h, p1)
		}
		if p2.freq > 0 {
			heap.Push(h, p2)
		}
	}

	if h.Len() == 1 {
		p := heap.Pop(h).(*Pair)
		result.WriteByte(p.char)
	}

	return result.String()
}