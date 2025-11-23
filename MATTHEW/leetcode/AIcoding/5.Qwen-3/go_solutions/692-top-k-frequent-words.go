package main

import (
	"container/heap"
	"strings"
)

type WordFreq struct {
	word  string
	freq  int
}

type MaxHeap []*WordFreq

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i].freq > h[j].freq || (h[i].freq == h[j].freq && h[i].word < h[j].word) }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
	*h = append(*h, x.(*WordFreq))
}

func (h *MaxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func topKFrequent(words []string, k int) []string {
	count := make(map[string]int)
	for _, word := range words {
		count[word]++
	}

	h := &MaxHeap{}
	for word, freq := range count {
		heap.Push(h, &WordFreq{word, freq})
	}

	result := make([]string, 0, k)
	for i := 0; i < k; i++ {
		result = append(result, heap.Pop(h).(*WordFreq).word)
	}

	return result
}