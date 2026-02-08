import "sort"

func maximumXOR(nums []int) int {
	res := 0
	for _, num := range nums {
		res |= num
	}
	return res
}

func maxScore(nums1 []int, nums2 []int, k int) []int64 {
	n := len(nums1)
	pairs := make([][]int, n)
	for i := 0; i < n; i++ {
		pairs[i] = []int{nums2[i], nums1[i]}
	}
	sort.Slice(pairs, func(i, j int) bool {
		return pairs[i][0] > pairs[j][0]
	})

	h := &IntHeap{}
	sum := 0
	res := make([]int64, n-k+1)
	for i := 0; i <= n-k; i++ {
		for j := i; j < i+k; j++ {
			sum += pairs[j][1]
			h.Push(pairs[j][1])
		}
		res[i] = int64(pairs[i+k-1][0]) * int64(sum)

		for h.Len() > 0 {
			h.Pop()
		}
		sum = 0
	}

	return res
}

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