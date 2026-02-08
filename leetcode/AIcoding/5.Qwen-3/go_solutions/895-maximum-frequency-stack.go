package main

type FreqStack struct {
    freq map[int]int
    groups map[int][]int
    maxFreq int
}

func Constructor() FreqStack {
    return FreqStack{
        freq: make(map[int]int),
        groups: make(map[int][]int),
        maxFreq: 0,
    }
}

func (this *FreqStack) Push(val int) {
    this.freq[val]++
    if this.freq[val] > this.maxFreq {
        this.maxFreq = this.freq[val]
    }
    this.groups[this.freq[val]] = append(this.groups[this.freq[val]], val)
}

func (this *FreqStack) Pop() int {
    val := this.groups[this.maxFreq][len(this.groups[this.maxFreq])-1]
    this.groups[this.maxFreq] = this.groups[this.maxFreq][:len(this.groups[this.maxFreq])-1]
    if len(this.groups[this.maxFreq]) == 0 {
        this.maxFreq--
    }
    this.freq[val]--
    return val
}