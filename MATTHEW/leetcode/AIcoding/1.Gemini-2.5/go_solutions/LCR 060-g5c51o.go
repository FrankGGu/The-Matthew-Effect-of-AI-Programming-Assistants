type Element struct {
	num  int
	freq int
}

type MinHeap []Element

func (h MinHeap) Len() int {
	return len(h)
}

func (h MinHeap) Less(i, j int) bool {
	return h[i].freq < h[j].freq
}

func (h MinHeap) Swap(i, j int) {
	h[i], h[j] = h[j], h[i]
}

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(Element))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func topKFrequent(nums []int, k int) []int {
	// 1. Count frequencies of each number
	freqMap := make(map[int]int)
	for _, num := range nums {
		freqMap[num]++
	}

	// 2. Use a min-heap to keep track of the k most frequent elements
	h := &MinHeap{}
	heap.Init(h)

	for num, freq := range freqMap {
		heap.Push(h, Element{num: num, freq: freq})
		// If the heap size exceeds k, remove the element with the smallest frequency
		if h.Len() > k {
			heap.Pop(h)
		}
	}

	// 3. Extract elements from the heap
	result := make([]int, k)
	for i := k - 1; i >= 0; i-- { // Pop in reverse order to maintain original frequency order if needed, though not required by problem
		result[i] = heap.Pop(h).(Element).num