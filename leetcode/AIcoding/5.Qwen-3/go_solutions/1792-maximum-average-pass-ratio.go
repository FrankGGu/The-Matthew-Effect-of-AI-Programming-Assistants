package main

func maxAveragePassRatio(employees []int, logs []string) float64 {
	type Log struct {
		id   int
		rate int
	}
	heap := make([]Log, 0, len(employees))
	for i := range employees {
		heap = append(heap, Log{i, 0})
	}
	for _, log := range logs {
		var id, rate int
		fmt.Sscanf(log, "%d %d", &id, &rate)
		heap[0] = Log{id, rate}
		heapify(heap, 0)
	}
	for i := 0; i < len(employees); i++ {
		employees[heap[i].id] += heap[i].rate
	}
	sum := 0
	for _, e := range employees {
		sum += e
	}
	return float64(sum) / float64(len(employees))
}

func heapify(heap []Log, i int) {
	n := len(heap)
	l := 2*i + 1
	r := 2*i + 2
	min := i
	if l < n && heap[l].rate < heap[min].rate {
		min = l
	}
	if r < n && heap[r].rate < heap[min].rate {
		min = r
	}
	if min != i {
		heap[i], heap[min] = heap[min], heap[i]
		heapify(heap, min)
	}
}