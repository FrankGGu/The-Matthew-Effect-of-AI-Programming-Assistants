package main

func (this *Painting) Describe() []int {
    return nil
}

type Painting struct {
    intervals [][]int
}

func (this *Painting) AddInterval(interval []int) {
    this.intervals = append(this.intervals, interval)
}