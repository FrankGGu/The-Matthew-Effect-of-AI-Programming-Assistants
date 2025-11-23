import "container/heap"

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

func maxSubsequence(nums []int, k int) []int {
	n := len(nums)
	h := &IntHeap{}
	heap.Init(h)
	for i := 0; i < k; i++ {
		heap.Push(h, nums[i])
	}
	for i := k; i < n; i++ {
		if nums[i] > (*h)[0] {
			heap.Pop(h)
			heap.Push(h, nums[i])
		}
	}
	res := make([]int, k)
	m := make(map[int]int)
	for i := 0; i < k; i++ {
		val := heap.Pop(h).(int)
		m[val]++
	}
	idx := 0
	for i := 0; i < n; i++ {
		if m[nums[i]] > 0 {
			res[idx] = nums[i]
			idx++
			m[nums[i]]--
		}
		if idx == k {
			break
		}
	}
	return res
}

func minSubsequence(nums []int, k int) []int {
	n := len(nums)
	h := &IntHeap{}
	heap.Init(h)
	for i := 0; i < k; i++ {
		heap.Push(h, -nums[i])
	}
	for i := k; i < n; i++ {
		if -nums[i] > (*h)[0] {
			heap.Pop(h)
			heap.Push(h, -nums[i])
		}
	}
	res := make([]int, k)
	m := make(map[int]int)
	for i := 0; i < k; i++ {
		val := -heap.Pop(h).(int)
		m[val]++
	}
	idx := 0
	for i := 0; i < n; i++ {
		if m[nums[i]] > 0 {
			res[idx] = nums[i]
			idx++
			m[nums[i]]--
		}
		if idx == k {
			break
		}
	}
	return res
}

func maxSubsequenceSum(nums []int, k int) int64 {
	arr := maxSubsequence(nums, k)
	var sum int64
	for _, num := range arr {
		sum += int64(num)
	}
	return sum
}

func minSubsequenceSum(nums []int, k int) int64 {
	arr := minSubsequence(nums, k)
	var sum int64
	for _, num := range arr {
		sum += int64(num)
	}
	return sum
}

func maxAndMinSubsequenceSums(nums []int, k int) []int64 {
	return []int64{maxSubsequenceSum(nums, k), minSubsequenceSum(nums, k)}
}