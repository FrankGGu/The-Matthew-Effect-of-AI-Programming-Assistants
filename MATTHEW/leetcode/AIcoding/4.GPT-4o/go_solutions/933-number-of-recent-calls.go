type RecentCounter struct {
    calls []int
}

func Constructor() RecentCounter {
    return RecentCounter{calls: []int{}}
}

func (this *RecentCounter) Ping(t int) int {
    this.calls = append(this.calls, t)
    for len(this.calls) > 0 && this.calls[0] < t-3000 {
        this.calls = this.calls[1:]
    }
    return len(this.calls)
}