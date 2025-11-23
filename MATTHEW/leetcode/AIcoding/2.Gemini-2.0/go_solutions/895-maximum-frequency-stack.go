type FreqStack struct {
	freq map[int]int
	group map[int][]int
	maxFreq int
}

func Constructor() FreqStack {
	return FreqStack{
		freq:    make(map[int]int),
		group:   make(map[int][]int),
		maxFreq: 0,
	}
}

func (this *FreqStack) Push(val int) {
	this.freq[val]++
	freq := this.freq[val]
	if freq > this.maxFreq {
		this.maxFreq = freq
	}
	this.group[freq] = append(this.group[freq], val)
}

func (this *FreqStack) Pop() int {
	val := this.group[this.maxFreq][len(this.group[this.maxFreq])-1]
	this.group[this.maxFreq] = this.group[this.maxFreq][:len(this.group[this.maxFreq])-1]
	this.freq[val]--
	if len(this.group[this.maxFreq]) == 0 {
		this.maxFreq--
	}
	return val
}