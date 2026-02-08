type CQueue struct {
    inStack []int
    outStack []int
}

func Constructor() CQueue {
    return CQueue{}
}

func (this *CQueue) AppendTail(value int)  {
    this.inStack = append(this.inStack, value)
}

func (this *CQueue) DeleteHead() int {
    if len(this.outStack) == 0 {
        for len(this.inStack) > 0 {
            this.outStack = append(this.outStack, this.inStack[len(this.inStack)-1])
            this.inStack = this.inStack[:len(this.inStack)-1]
        }
    }
    if len(this.outStack) == 0 {
        return -1
    }
    val := this.outStack[len(this.outStack)-1]
    this.outStack = this.outStack[:len(this.outStack)-1]
    return val
}