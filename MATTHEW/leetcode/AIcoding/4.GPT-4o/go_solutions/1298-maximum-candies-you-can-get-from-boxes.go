import "container/heap"

type Box struct {
    candies int
    numBoxes int
}

type MaxHeap []Box

func (h MaxHeap) Len() int {
    return len(h)
}

func (h MaxHeap) Less(i, j int) bool {
    return h[i].candies > h[j].candies
}

func (h MaxHeap) Swap(i, j int) {
    h[i], h[j] = h[j], h[i]
}

func (h *MaxHeap) Push(x interface{}) {
    *h = append(*h, x.(Box))
}

func (h *MaxHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}

func maxCandies(boxes []int, numRestrictedBoxes int) int {
    h := &MaxHeap{}
    heap.Init(h)

    for i := 0; i < len(boxes); i++ {
        heap.Push(h, Box{candies: boxes[i], numBoxes: 1})
    }

    totalCandies := 0
    for h.Len() > 0 && numRestrictedBoxes > 0 {
        box := heap.Pop(h).(Box)
        totalCandies += box.candies

        if box.numBoxes < box.candies {
            heap.Push(h, Box{candies: box.candies - 1, numBoxes: box.numBoxes + 1})
        }
        numRestrictedBoxes--
    }

    return totalCandies
}