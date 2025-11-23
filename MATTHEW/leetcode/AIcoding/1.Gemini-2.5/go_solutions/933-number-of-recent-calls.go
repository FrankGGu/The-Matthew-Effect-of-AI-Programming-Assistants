import (
	"container/list"
)

type RecentCounter struct {
	q *list.List
}

func Constructor() RecentCounter {
	return RecentCounter{
		q: list.New(),
	}
}

func (this *RecentCounter) Ping(t int) int {
	this.q.PushBack(t)

	for {
		front := this.q.Front()
		if front == nil {
			break
		}

		val := front.Value.(int)
		if val < t-3000 {
			this.q.Remove(front)
		} else {
			break
		}
	}

	return this.q.Len()
}