import (
	"container/heap"
	"sort"
)

type WordCount struct {
	Word  string
	Count int
}

type PriorityQueue []WordCount

func (pq PriorityQueue) Len() int {
	return len(pq)
}

func (pq PriorityQueue) Less(i, j int) bool {
	if pq[i].Count == pq[j].Count {
		return pq[i].Word > pq[j].Word
	}
	return pq[i].Count < pq[j].Count
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	item := x.(WordCount)
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func topKFrequent(words []string, k int) []string {
	wordCounts := make(map[string]int)
	for _, word := range words {
		wordCounts[word]++
	}

	pq := &PriorityQueue{}
	heap.Init(pq)

	for word, count := range wordCounts {
		heap.Push(pq, WordCount{Word: word, Count: count})
		if pq.Len() > k {
			heap.Pop(pq)
		}
	}

	result := make([]string, k)
	for i := k - 1; i >= 0; i-- {
		item := heap.Pop(pq).(WordCount)
		result[i] = item.Word
	}

	return result
}