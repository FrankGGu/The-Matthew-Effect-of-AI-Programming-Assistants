type FreqStack struct {
    freq    map[int]int
    stacks  map[int][]int
    maxFreq int
}

func Constructor() FreqStack {
    return FreqStack{
        freq:    make(map[int]int),
        stacks:  make(map[int][]int),
        maxFreq: 0,
    }
}

func (this *FreqStack) Push(val int) {
    this.freq[val]++
    f := this.freq[val]
    if f > this.maxFreq {
        this.maxFreq = f
    }
    this.stacks[f] = append(this.stacks[f], val)
}

func (this *FreqStack) Pop() int {
    stack := this.stacks[this.maxFreq]
    val := stack[len(stack)-1]
    this.stacks[this.maxFreq] = stack[:len(stack)-1]
    this.freq[val]--
    if len(this.stacks[this.maxFreq]) == 0 {
        this.maxFreq--
    }
    return val
}

/**
 * Your FreqStack object will be instantiated and called as such:
 * obj := Constructor();
 * obj.Push(val);
 * param_2 := obj.Pop();
 */