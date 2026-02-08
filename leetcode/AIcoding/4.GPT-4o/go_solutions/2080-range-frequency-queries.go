type FrequencyTracker struct {
    frequency map[int]int
    count     map[int]int
}

func Constructor() FrequencyTracker {
    return FrequencyTracker{
        frequency: make(map[int]int),
        count:     make(map[int]int),
    }
}

func (this *FrequencyTracker) Add(number int) {
    if this.frequency[number] > 0 {
        this.count[this.frequency[number]]--
    }
    this.frequency[number]++
    this.count[this.frequency[number]]++
}

func (this *FrequencyTracker) Delete(number int) {
    if this.frequency[number] > 0 {
        this.count[this.frequency[number]]--
        this.frequency[number]--
        if this.frequency[number] > 0 {
            this.count[this.frequency[number]]++
        }
    }
}

func (this *FrequencyTracker) GetFrequency(frequency int) int {
    return this.count[frequency]
}