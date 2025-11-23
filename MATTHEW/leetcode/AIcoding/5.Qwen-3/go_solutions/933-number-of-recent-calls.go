package main

type RecentCalls struct {
    queue []int
}

func Constructor() RecentCalls {
    return RecentCalls{
        queue: make([]int, 0),
    }
}

func (this *RecentCalls) Ping(t int) int {
    this.queue = append(this.queue, t)
    for this.queue[0] < t-3000 {
        this.queue = this.queue[1:]
    }
    return len(this.queue)
}