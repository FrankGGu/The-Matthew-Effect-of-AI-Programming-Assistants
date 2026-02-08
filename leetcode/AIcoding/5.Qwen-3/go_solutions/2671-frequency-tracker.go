package main

type FrequencyTracker struct {
    count map[int]int
    freq  map[int]int
}

func Constructor() FrequencyTracker {
    return FrequencyTracker{
        count: make(map[int]int),
        freq:  make(map[int]int),
    }
}

func (this *FrequencyTracker) Add(number int) {
    if this.count[number] > 0 {
        this.freq[this.count[number]]--
        if this.freq[this.count[number]] == 0 {
            delete(this.freq, this.count[number])
        }
    }
    this.count[number]++
    this.freq[this.count[number]]++
}

func (this *FrequencyTracker) Delete(number int) {
    if this.count[number] > 0 {
        this.freq[this.count[number]]--
        if this.freq[this.count[number]] == 0 {
            delete(this.freq, this.count[number])
        }
        this.count[number]--
        if this.count[number] > 0 {
            this.freq[this.count[number]]++
        }
    }
}

func (this *FrequencyTracker) HasFrequency(frequency int) bool {
    _, exists := this.freq[frequency]
    return exists
}