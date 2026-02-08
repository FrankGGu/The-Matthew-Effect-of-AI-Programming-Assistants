type RecentCounter struct {
	q []int
}

func Constructor() RecentCounter {
	return RecentCounter{
		q: make([]int, 0),
	}
}

func (this *RecentCounter) Ping(t int) int {
	this.q = append(this.q, t)
	for len(this.q) > 0 && this.q[0] < t-3000 {
		this.q = this.q[1:]
	}
	return len(this.q)
}