import (
    "container/heap"
    "math"
)

type Item struct {
    value int
    listIndex int
    elementIndex int
}

type MinHeap []Item

func (h MinHeap) Len() int { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].value < h[j].value }
func (h MinHeap) Swap(i, j int) { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
    *h = append(*h, x.(Item))
}

func (h *MinHeap) Pop() interface{} {
    old := *h
    n := len(old)
    item := old[n-1]
    *h = old[0 : n-1]
    return item
}

func smallestRange(nums [][]int) []int {
    minHeap := &MinHeap{}
    currentMax := math.MinInt32
    for i := range nums {
        heap.Push(minHeap, Item{value: nums[i][0], listIndex: i, elementIndex: 0})
        currentMax = max(currentMax, nums[i][0])
    }

    rangeStart, rangeEnd := -1, -1
    smallestRange := math.MaxInt32

    for minHeap.Len() > 0 {
        currentMin := (*minHeap)[0].value
        if currentMax - currentMin < smallestRange {
            smallestRange = currentMax - currentMin
            rangeStart = currentMin
            rangeEnd = currentMax
        }

        item := heap.Pop(minHeap).(Item)
        if item.elementIndex + 1 < len(nums[item.listIndex]) {
            nextItem := Item{value: nums[item.listIndex][item.elementIndex + 1], listIndex: item.listIndex, elementIndex: item.elementIndex + 1}
            heap.Push(minHeap, nextItem)
            currentMax = max(currentMax, nextItem.value)
        } else {
            break
        }
    }

    return []int{rangeStart, rangeEnd}
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}