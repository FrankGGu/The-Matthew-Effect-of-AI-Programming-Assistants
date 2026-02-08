import (
	"container/heap"
)

func magicTower(nums []int) int {
	sum := 0
	for _, num := range nums {
		sum += num
	}
	if sum < 0 {
		return -1
	}

	pq := &IntHeap{}
	heap.Init(pq)

	ans := 0
	cur := 1
	for i := 0; i < len(nums); i++ {
		cur += nums[i]
		if nums[i] < 0 {
			heap.Push(pq, nums[i])
		}
		for cur <= 0 {
			val := heap.Pop(pq).(int)
			cur -= val
			ans++
		}
	}

	return ans
}

type IntHeap []int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i] < h[j] }
func (h IntHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *IntHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *IntHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}