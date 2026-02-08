package main

func longestHappyString(a int, b int, c int) string {
    maxHeap := &MaxHeap{}
    if a > 0 {
        heap.Push(maxHeap, [2]int{a, 'a'})
    }
    if b > 0 {
        heap.Push(maxHeap, [2]int{b, 'b'})
    }
    if c > 0 {
        heap.Push(maxHeap, [2]int{c, 'c'})
    }

    result := []rune{}
    for maxHeap.Len() > 0 {
        first := heap.Pop(maxHeap).([2]int)
        if len(result) >= 2 && result[len(result)-1] == rune(first[1]) && result[len(result)-2] == rune(first[1]) {
            if maxHeap.Len() == 0 {
                break
            }
            second := heap.Pop(maxHeap).([2]int)
            result = append(result, rune(second[1]))
            second[0]--
            if second[0] > 0 {
                heap.Push(maxHeap, second)
            }
            heap.Push(maxHeap, first)
        } else {
            result = append(result, rune(first[1]))
            first[0]--
            if first[0] > 0 {
                heap.Push(maxHeap, first)
            }
        }
    }
    return string(result)
}

type MaxHeap [][2]int

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i][0] > h[j][0] }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
    *h = append(*h, x.([2]int))
}

func (h *MaxHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}