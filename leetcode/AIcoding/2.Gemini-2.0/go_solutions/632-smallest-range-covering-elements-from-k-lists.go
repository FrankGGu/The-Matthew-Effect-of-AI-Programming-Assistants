import (
	"container/heap"
	"math"
)

type Element struct {
	Val   int
	Row   int
	Col   int
}

type PriorityQueue []Element

func (pq PriorityQueue) Len() int {
	return len(pq)
}

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].Val < pq[j].Val
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	item := x.(Element)
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func smallestRange(nums [][]int) []int {
	k := len(nums)
	pq := &PriorityQueue{}
	heap.Init(pq)

	maxVal := math.MinInt32
	for i := 0; i < k; i++ {
		heap.Push(pq, Element{nums[i][0], i, 0})
		maxVal = max(maxVal, nums[i][0])
	}

	rangeStart, rangeEnd := 0, math.MaxInt32
	for {
		element := heap.Pop(pq).(Element)
		minVal := element.Val

		if rangeEnd-rangeStart > maxVal-minVal {
			rangeStart = minVal
			rangeEnd = maxVal
		}

		row, col := element.Row, element.Col
		if col+1 == len(nums[row]) {
			break
		}

		newVal := nums[row][col+1]
		maxVal = max(maxVal, newVal)
		heap.Push(pq, Element{newVal, row, col + 1})
	}

	return []int{rangeStart, rangeEnd}
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}