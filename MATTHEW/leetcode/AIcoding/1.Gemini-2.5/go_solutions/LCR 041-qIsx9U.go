type MovingAverage struct {
	queue []int
	size  int
	sum   int
}

func Constructor(size int) MovingAverage {
	return MovingAverage{
		queue: make([]int, 0, size),
		size:  size,
		sum:   0,
	}
}

func (this *MovingAverage) Next(val int) float64 {
	if len(this.queue) == this.size {
		this.sum -= this.queue[0]
		this.queue = this.queue[1:]
	}
	this.queue = append(this.queue, val)
	this.sum += val
	return float64(this.sum) / float64(len(this.queue))
}