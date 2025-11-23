import (
	"container/heap"
	"container/list"
)

type minHeap []int

func (h minHeap) Len() int           { return len(h) }
func (h minHeap) Less(i, j int) bool { return h[i] < h[j] }
func (h minHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }
func (h *minHeap) Push(x any)       { *h = append(*h, x.(int)) }
func (h *minHeap) Pop() any         { old := *h; n := len(old); x := old[n-1]; *h = old[0 : n-1]; return x }

type maxHeap []int

func (h maxHeap) Len() int           { return len(h) }
func (h maxHeap) Less(i, j int) bool { return h[i] > h[j] } // Max-heap
func (h maxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }
func (h *maxHeap) Push(x any)       { *h = append(*h, x.(int)) }
func (h *maxHeap) Pop() any         { old := *h; n := len(old); x := old[n-1]; *h = old[0 : n-1]; return x }

type MKAverage struct {
	m, k int
	q    *list.List // Deque for sliding window

	left  *maxHeap // Max-heap for k smallest elements
	mid   *minHeap // Min-heap for m-2k middle elements
	right *minHeap // Min-heap for k largest elements

	leftSize  int // Number of valid elements in left heap
	midSize   int // Number of valid elements in mid heap
	rightSize int // Number of valid elements in right heap

	midSum int64 // Sum of elements in mid heap

	// Lazy deletion counts for elements no longer in window
	removed map[int]int
}

func Constructor(m int, k int) MKAverage {
	return MKAverage{
		m:       m,
		k:       k,
		q:       list.New(),
		left:    &maxHeap{},
		mid:     &minHeap{},
		right:   &minHeap{},
		removed: make(map[int]int),
	}
}

func (this *MKAverage) popActual(h interface{}, isMaxHeap bool) int {
	var val int
	for {
		if isMaxHeap {
			val = heap.Pop(h.(*maxHeap)).(int)
		} else {
			val = heap.Pop(h.(*minHeap)).(int)
		}
		if count, ok := this.removed[val]; ok && count > 0 {
			this.removed[val]--
		} else {
			return val
		}
	}
}

func (this *MKAverage) peekActual(h interface{}, isMaxHeap bool) (int, bool) {
	for {
		var currentLen int
		if isMaxHeap {
			currentLen = h.(*maxHeap).Len()
		} else {
			currentLen = h.(*minHeap).Len()
		}
		if currentLen == 0 {
			return 0, false // Heap is empty after skipping
		}

		var val int
		if isMaxHeap {
			val = (*h.(*maxHeap))[0]
		} else {
			val = (*h.(*minHeap))[0]
		}

		if count, ok := this.removed[val]; ok && count > 0 {
			// This element is marked for removal, so it's not the true top.
			// Pop it to reveal the actual top.
			if isMaxHeap {
				heap.Pop(h.(*maxHeap))
			} else {
				heap.Pop(h.(*minHeap))
			}
			this.removed[val]--
		} else {
			return val, true
		}
	}
}

func (this *MKAverage) moveLeftToMid() {
	val := this.popActual(this.left, true)
	heap.Push(this.mid, val)
	this.leftSize--
	this.midSize++
	this.midSum += int64(val)
}

func (this *MKAverage) moveMidToLeft() {
	val := this.popActual(this.mid, false)
	heap.Push(this.left, val)
	this.midSize--
	this.leftSize++
	this.midSum -= int64(val)
}

func (this *MKAverage) moveMidToRight() {
	val := this.popActual(this.mid, false)
	heap.Push(this.right, val)
	this.midSize--
	this.rightSize++
	this.midSum -= int64(val)
}

func (this *MKAverage) moveRightToMid() {
	val := this.popActual(this.right, false)
	heap.Push(this.mid, val)
	this.rightSize--
	this.midSize++
	this.midSum += int64(val)
}

func (this *MKAverage) balance() {
	for {
		changed := false

		// Phase 1: Adjust sizes to target k, m-2k, k
		for this.leftSize < this.k && this.midSize > 0 {
			this.moveMidToLeft()
			changed = true
		}
		for this.rightSize < this.k && this.midSize > 0 {
			this.moveMidToRight()
			changed = true
		}
		for this.leftSize > this.k {
			this.moveLeftToMid()
			changed = true
		}
		for this.rightSize > this.k {
			this.moveRightToMid()
			changed = true
		}
		for this.midSize > this.m-2*this.k {
			// If mid has too many, move to right (as it's the larger partition)
			this.moveMidToRight()
			changed = true
		}

		// Phase 2: Ensure order invariant: max(left) <= min(mid) <= min(right)
		leftTop, hasLeft := this.peekActual(this.left, true)
		midTop, hasMid := this.peekActual(this.mid, false)
		rightTop, hasRight := this.peekActual(this.right, false)

		if hasLeft && hasMid && leftTop > midTop {
			// Swap leftTop and midTop
			valLeft := this.popActual(this.left, true)
			valMid := this.popActual(this.mid, false)

			heap.Push(this.left, valMid)
			heap.Push(this.mid, valLeft)

			this.midSum -= int64(valMid)
			this.midSum += int64(valLeft)
			changed = true
		}

		if hasMid && hasRight && midTop > rightTop {
			// Swap midTop and rightTop
			valMid := this.popActual(this.mid, false)
			valRight := this.popActual(this.right, false)

			heap.Push(this.mid, valRight)
			heap.Push(this.right, valMid)

			this.midSum -= int64(valMid)
			this.midSum += int64(valRight)
			changed = true
		}

		if !changed {
			break
		}
	}
}

func (this *MKAverage) AddElement(num int) {
	this.q.PushBack(num)

	// Always add to mid heap initially, then balance to distribute
	heap.Push(this.mid, num)
	this.midSize++
	this.midSum += int64(num)

	if this.q.Len() > this.m {
		oldest := this.q.Remove(this.q.Front()).(int)
		this.removed[oldest]++ // Mark for lazy deletion
	}
	this.balance()
}

func (this *MKAverage) CalculateMKAverage() int {
	if this.q.Len() < this.m {
		return -1
	}

	// After balance, midSize should be m-2k and midSum should be correct.
	if this.midSize == 0 {
		return 0 // If m-2k = 0, average is 0.
	}
	return int(this.midSum / int64(this.midSize))
}