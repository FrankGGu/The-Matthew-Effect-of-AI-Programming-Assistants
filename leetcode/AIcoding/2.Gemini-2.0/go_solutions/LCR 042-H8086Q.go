type RecentCounter struct {
	requests []int
}

func Constructor() RecentCounter {
	return RecentCounter{requests: []int{}}
}

func (this *RecentCounter) Ping(t int) int {
	this.requests = append(this.requests, t)
	for len(this.requests) > 0 && this.requests[0] < t-3000 {
		this.requests = this.requests[1:]
	}
	return len(this.requests)
}