type DinnerPlates struct {
    capacity int
    stacks   [][]int
    left     *IntHeap
    right    *IntHeap
}

func Constructor(capacity int) DinnerPlates {
    return DinnerPlates{
        capacity: capacity,
        stacks:   make([][]int, 0),
        left:     &IntHeap{},
        right:    &IntHeap{},
    }
}

func (this *DinnerPlates) Push(val int) {
    for this.left.Len() > 0 {
        idx := heap.Pop(this.left).(int)
        if idx < len(this.stacks) && len(this.stacks[idx]) < this.capacity {
            this.stacks[idx] = append(this.stacks[idx], val)
            if len(this.stacks[idx]) < this.capacity {
                heap.Push(this.left, idx)
            }
            heap.Push(this.right, -idx)
            return
        }
    }
    newStack := []int{val}
    this.stacks = append(this.stacks, newStack)
    idx := len(this.stacks) - 1
    if this.capacity > 1 {
        heap.Push(this.left, idx)
    }
    heap.Push(this.right, -idx)
}

func (this *DinnerPlates) Pop() int {
    for this.right.Len() > 0 {
        idx := -heap.Pop(this.right).(int)
        if idx < len(this.stacks) && len(this.stacks[idx]) > 0 {
            stack := this.stacks[idx]
            val := stack[len(stack)-1]
            this.stacks[idx] = stack[:len(stack)-1]
            if len(this.stacks[idx]) == this.capacity-1 {
                heap.Push(this.left, idx)
            }
            return val
        }
    }
    return -1
}

func (this *DinnerPlates) PopAtStack(index int) int {
    if index >= len(this.stacks) || len(this.stacks[index]) == 0 {
        return -1
    }
    stack := this.stacks[index]
    val := stack[len(stack)-1]
    this.stacks[index] = stack[:len(stack)-1]
    if len(this.stacks[index]) == this.capacity-1 {
        heap.Push(this.left, index)
    }
    return val
}

type IntHeap []int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i] < h[j] }
func (h IntHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }
func (h *IntHeap) Push(x interface{}) {
    *h = append(*h, x.(int))
}
func (h *IntHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}