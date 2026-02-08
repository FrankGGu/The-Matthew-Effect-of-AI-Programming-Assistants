type FrequencyTracker struct {
	counts     map[int]int
	freqCounts map[int]int
}

func Constructor() FrequencyTracker {
	return FrequencyTracker{
		counts:     make(map[int]int),
		freqCounts: make(map[int]int),
	}
}

func (this *FrequencyTracker) Add(number int) {
	oldFreq := this.counts[number]
	this.counts[number]++
	newFreq := this.counts[number]

	if oldFreq > 0 {
		this.freqCounts[oldFreq]--
		if this.freqCounts[oldFreq] == 0 {
			delete(this.freqCounts, oldFreq)
		}
	}

	this.freqCounts[newFreq]++
}

func (this *FrequencyTracker) Delete(number int) {
	oldFreq := this.counts[number]

	if oldFreq == 0 {
		return
	}

	this.counts[number]--
	newFreq := this.counts[number]

	this.freqCounts[oldFreq]--
	if this.freqCounts[oldFreq] == 0 {
		delete(this.freqCounts, oldFreq)
	}

	if newFreq > 0 {
		this.freqCounts[newFreq]++
	} else {
		delete(this.counts, number)
	}
}

func (this *FrequencyTracker) Query(frequency int) int {
	return this.freqCounts[frequency]
}