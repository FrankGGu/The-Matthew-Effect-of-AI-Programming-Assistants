import "container/heap"

type Pair struct {
	Index int
	Value int
}

type PriorityQueue []Pair

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].Value > pq[j].Value
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	item := x.(Pair)
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func maxResult(nums []int, k int) int {
	n := len(nums)
	dp := make([]int, n)
	dp[0] = nums[0]

	pq := &PriorityQueue{{0, nums[0]}}
	heap.Init(pq)

	for i := 1; i < n; i++ {
		for pq.Len() > 0 && (*pq)[0].Index < i-k {
			heap.Pop(pq)
		}
		dp[i] = (*pq)[0].Value + nums[i]
		heap.Push(pq, Pair{i, dp[i]})
	}

	return dp[n-1]
}