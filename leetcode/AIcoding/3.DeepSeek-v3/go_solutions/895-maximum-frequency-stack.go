type FreqStack struct {
    freq    map[int]int
    group   map[int][]int
    maxFreq int
}

func Constructor() FreqStack {
    return FreqStack{
        freq:  make(map[int]int),
        group: make(map[int][]int),
    }
}

func (this *FreqStack) Push(val int) {
    f := this.freq[val] + 1
    this.freq[val] = f
    if f > this.maxFreq {
        this.maxFreq = f
    }
    this.group[f] = append(this.group[f], val)
}

func (this *FreqStack) Pop() int {
    vals := this.group[this.maxFreq]
    val := vals[len(vals)-1]
    this.group[this.maxFreq] = vals[:len(vals)-1]
    this.freq[val]--
    if len(this.group[this.maxFreq]) == 0 {
        this.maxFreq--
    }
    return val
}