package main

import "container/heap"

type MedianFinder struct {
    left  hp
    right hp
}

func Constructor() MedianFinder {
    return MedianFinder{
        left:  hp{},
        right: hp{},
    }
}

func (this *MedianFinder) AddNum(num int) {
    if len(this.left) == 0 || num <= this.left[0] {
        heap.Push(&this.left, num)
    } else {
        heap.Push(&this.right, num)
    }

    if len(this.left) > len(this.right)+1 {
        heap.Push(&this.right, heap.Pop(&this.left))
    } else if len(this.right) > len(this.left) {
        heap.Push(&this.left, heap.Pop(&this.right))
    }
}

func (this *MedianFinder) FindMedian() float64 {
    if len(this.left) == len(this.right) {
        return float64(this.left[0]+this.right[0]) / 2.0
    }
    return float64(this.left[0])
}

type hp []int

func (h hp) Len() int           { return len(h) }
func (h hp) Less(i, j int) bool { return h[i] > h[j] }
func (h hp) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *hp) Push(x interface{}) {
    *h = append(*h, x.(int))
}

func (h *hp) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}