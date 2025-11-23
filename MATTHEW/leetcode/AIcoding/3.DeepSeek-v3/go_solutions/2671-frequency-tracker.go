type FrequencyTracker struct {
    freq map[int]int
    freqCount map[int]int
}

func Constructor() FrequencyTracker {
    return FrequencyTracker{
        freq: make(map[int]int),
        freqCount: make(map[int]int),
    }
}

func (this *FrequencyTracker) Add(number int) {
    if oldFreq, exists := this.freq[number]; exists {
        this.freqCount[oldFreq]--
        if this.freqCount[oldFreq] == 0 {
            delete(this.freqCount, oldFreq)
        }
    }
    this.freq[number]++
    newFreq := this.freq[number]
    this.freqCount[newFreq]++
}

func (this *FrequencyTracker) DeleteOne(number int) {
    if oldFreq, exists := this.freq[number]; exists {
        this.freqCount[oldFreq]--
        if this.freqCount[oldFreq] == 0 {
            delete(this.freqCount, oldFreq)
        }
        this.freq[number]--
        if this.freq[number] == 0 {
            delete(this.freq, number)
        } else {
            newFreq := this.freq[number]
            this.freqCount[newFreq]++
        }
    }
}

func (this *FrequencyTracker) HasFrequency(frequency int) bool {
    return this.freqCount[frequency] > 0
}

/**
 * Your FrequencyTracker object will be instantiated and called as such:
 * obj := Constructor();
 * obj.Add(number);
 * obj.DeleteOne(number);
 * param_3 := obj.HasFrequency(frequency);
 */