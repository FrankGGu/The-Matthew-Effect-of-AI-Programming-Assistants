type FrequencyTracker struct {
    numFreq map[int]int
    freqFreq map[int]int
}

func Constructor() FrequencyTracker {
    return FrequencyTracker{
        numFreq: make(map[int]int),
        freqFreq: make(map[int]int),
    }
}

func (this *FrequencyTracker) Add(number int)  {
    freq := this.numFreq[number]
    this.numFreq[number]++

    if freq > 0 {
        this.freqFreq[freq]--
        if this.freqFreq[freq] == 0 {
            delete(this.freqFreq, freq)
        }
    }

    this.freqFreq[freq+1]++
}

func (this *FrequencyTracker) DeleteOne(number int)  {
    freq := this.numFreq[number]
    if freq == 0 {
        return
    }

    this.numFreq[number]--

    this.freqFreq[freq]--
    if this.freqFreq[freq] == 0 {
        delete(this.freqFreq, freq)
    }

    if this.numFreq[number] > 0 {
        this.freqFreq[freq-1]++
    }
}

func (this *FrequencyTracker) HasFrequency(frequency int) bool {
    _, ok := this.freqFreq[frequency]
    return ok
}