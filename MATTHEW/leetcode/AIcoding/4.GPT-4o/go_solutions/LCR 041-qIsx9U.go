type MovingAverage struct {
    size  int
    count int
    sum   float64
    queue []int
}

func Constructor(size int) MovingAverage {
    return MovingAverage{
        size: size,
        queue: make([]int, 0, size),
    }
}

func (this *MovingAverage) Next(val int) float64 {
    if this.count < this.size {
        this.queue = append(this.queue, val)
        this.sum += float64(val)
        this.count++
    } else {
        this.sum += float64(val) - float64(this.queue[0])
        this.queue = this.queue[1:]
        this.queue = append(this.queue, val)
    }
    return this.sum / float64(this.count)
}