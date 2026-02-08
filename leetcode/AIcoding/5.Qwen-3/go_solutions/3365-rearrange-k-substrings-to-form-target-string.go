package main

func rearrangeString(k int, s string) string {
    if k == 0 {
        return s
    }

    count := make(map[rune]int)
    for _, c := range s {
        count[c]++
    }

    type pair struct {
        char  rune
        count int
    }

    maxHeap := &maxHeap{}
    for c, cnt := range count {
        heap.Push(maxHeap, pair{c, cnt})
    }

    var result []rune
    var queue []pair

    for len(result) < len(s) {
        if maxHeap.Len() == 0 {
            return ""
        }

        p := heap.Pop(maxHeap).(pair)
        result = append(result, p.char)
        p.count--

        queue = append(queue, p)

        if len(queue) >= k {
            front := queue[0]
            queue = queue[1:]
            if front.count > 0 {
                heap.Push(maxHeap, front)
            }
        }
    }

    return string(result)
}

type maxHeap []pair

func (h maxHeap) Len() int           { return len(h) }
func (h maxHeap) Less(i, j int) bool { return h[i].count > h[j].count }
func (h maxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *maxHeap) Push(x interface{}) {
    *h = append(*h, x.(pair))
}

func (h *maxHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}