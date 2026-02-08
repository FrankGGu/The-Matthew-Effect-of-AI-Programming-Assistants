package main

type RangeFrequencyQueries struct {
    freq map[int]map[int]int
}

func Constructor() RangeFrequencyQueries {
    return RangeFrequencyQueries{
        freq: make(map[int]map[int]int),
    }
}

func (this *RangeFrequencyQueries) Add(value int) {
    if this.freq[value] == nil {
        this.freq[value] = make(map[int]int)
    }
    this.freq[value][len(this.freq[value])]++
}

func (this *RangeFrequencyQueries) Query(value int, left int, right int) int {
    if this.freq[value] == nil {
        return 0
    }
    count := 0
    for i := left; i <= right; i++ {
        count += this.freq[value][i]
    }
    return count
}