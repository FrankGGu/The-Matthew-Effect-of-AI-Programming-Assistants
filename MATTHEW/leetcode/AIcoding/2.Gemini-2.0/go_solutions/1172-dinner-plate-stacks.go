import "container/heap"

type DinnerPlates struct {
	capacity int
	stacks   []([]int)
	left     minHeap
	right    maxHeap
}

type minHeap []int

func (h minHeap) Len() int           { return len(h) }
func (h minHeap) Less(i, j int) bool { return h[i] < h[j] }
func (h minHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *minHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *minHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

type maxHeap []int

func (h maxHeap) Len() int           { return len(h) }
func (h maxHeap) Less(i, j int) bool { return h[i] > h[j] }
func (h maxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *maxHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *maxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func Constructor(capacity int) DinnerPlates {
	return DinnerPlates{
		capacity: capacity,
		stacks:   []([]int){},
		left:     minHeap{},
		right:    maxHeap{},
	}
}

func (this *DinnerPlates) Push(val int) {
	for len(this.left) > 0 && this.left[0] >= len(this.stacks) {
		heap.Pop(&this.left)
	}
	if len(this.left) > 0 {
		idx := heap.Pop(&this.left).(int)
		this.stacks[idx] = append(this.stacks[idx], val)
		heap.Push(&this.right, idx)
	} else {
		this.stacks = append(this.stacks, []int{val})
		heap.Push(&this.right, len(this.stacks)-1)
	}
}

func (this *DinnerPlates) Pop() int {
	for len(this.right) > 0 && len(this.stacks[this.right[0]]) == 0 {
		heap.Pop(&this.right)
	}
	if len(this.right) == 0 {
		return -1
	}
	idx := heap.Pop(&this.right).(int)
	val := this.stacks[idx][len(this.stacks[idx])-1]
	this.stacks[idx] = this.stacks[idx][:len(this.stacks[idx])-1]

	for len(this.stacks) > 0 && len(this.stacks[len(this.stacks)-1]) == 0 {
		this.stacks = this.stacks[:len(this.stacks)-1]
	}
	return val
}

func (this *DinnerPlates) PopAtStack(index int) int {
	if index >= len(this.stacks) || len(this.stacks[index]) == 0 {
		return -1
	}
	val := this.stacks[index][len(this.stacks[index])-1]
	this.stacks[index] = this.stacks[index][:len(this.stacks[index])-1]
	heap.Push(&this.left, index)

	for len(this.stacks) > 0 && len(this.stacks[len(this.stacks)-1]) == 0 {
		this.stacks = this.stacks[:len(this.stacks)-1]
	}

	return val
}