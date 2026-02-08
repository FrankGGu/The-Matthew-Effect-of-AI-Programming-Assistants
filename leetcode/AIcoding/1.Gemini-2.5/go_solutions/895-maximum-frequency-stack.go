type FreqStack struct {
    freqMap    map[int]int
    freqStacks map[int][]int
    maxFreq    int
}

func Constructor() FreqStack {
    return FreqStack{
        freqMap:    make(map[int]int),
        freqStacks: make(map[int][]int),
        maxFreq:    0,
    }
}

func (this *FreqStack) Push(val int) {
    this.freqMap[val]++
    currentFreq := this.freqMap[val]

    if currentFreq > this.maxFreq {
        this.maxFreq = currentFreq
    }

    this.freqStacks[currentFreq] = append(this.freqStacks[currentFreq], val)
}

func (this *FreqStack) Pop() int {
    stack := this.freqStacks[this.maxFreq]
    n := len(stack)
    val := stack[n-1]

    this.freqStacks[this.maxFreq] = stack[:n-1]

    this.freqMap[val]--

    if len(this.freqStacks[this.maxFreq]) == 0 {
        this.maxFreq--
    }

    return val
}