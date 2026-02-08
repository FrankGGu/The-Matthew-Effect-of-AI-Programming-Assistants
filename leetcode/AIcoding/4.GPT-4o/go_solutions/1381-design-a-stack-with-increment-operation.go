type CustomStack struct {
    stack []int
    maxSize int
}

func Constructor(maxSize int) CustomStack {
    return CustomStack{
        stack:   make([]int, 0, maxSize),
        maxSize: maxSize,
    }
}

func (this *CustomStack) Push(x int) {
    if len(this.stack) < this.maxSize {
        this.stack = append(this.stack, x)
    }
}

func (this *CustomStack) Pop() int {
    if len(this.stack) == 0 {
        return -1
    }
    val := this.stack[len(this.stack)-1]
    this.stack = this.stack[:len(this.stack)-1]
    return val
}

func (this *CustomStack) Increment(k int, val int) {
    if k > len(this.stack) {
        k = len(this.stack)
    }
    for i := 0; i < k; i++ {
        this.stack[i] += val
    }
}