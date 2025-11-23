import (
	"container/heap"
	"sort"
)

type IntHeap []int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i] > h[j] }
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

func kSum(nums []int, k int) int64 {
	sum := 0
	for i := 0; i < len(nums); i++ {
		if nums[i] >= 0 {
			sum += nums[i]
		} else {
			nums[i] = -nums[i]
		}
	}
	sort.Ints(nums)

	h := &IntHeap{}
	heap.Init(h)
	heap.Push(h, nums[0])
	visited := make(map[string]bool)
	visited["0,0"] = true

	var result int64 = 0
	var index int
	for i := 1; i < k; i++ {
		result = int64(heap.Pop(h).(int))

		index = 0
		for index < len(nums) {
			nextSum := result + int64(nums[index])
			nextIndex := index + 1

			key := string(index+100000) + "," + string(nextIndex+100000)
			if !visited[key] {
				heap.Push(h, int(nextSum))
				visited[key] = true
			}
			index++
		}
	}
	if k == 1 {
		return int64(sum)
	}
	result = int64(heap.Pop(h).(int))

	return int64(sum) - result
}