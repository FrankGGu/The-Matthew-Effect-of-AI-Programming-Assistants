package main

type MovingAverage struct {
    size int
    queue []int
    sum int
}

func Constructor(size int) MovingAverage {
    return MovingAverage{
        size: size,
        queue: make([]int, 0),
        sum: 0,
    }
}

func (this *MovingAverage) Next(val int) float64 {
    this.queue = append(this.queue, val)
    this.sum += val
    if len(this.queue) > this.size {
        this.sum -= this.queue[0]
        this.queue = this.queue[1:]
    }
    return float64(this.sum) / float64(len(this.queue))
}