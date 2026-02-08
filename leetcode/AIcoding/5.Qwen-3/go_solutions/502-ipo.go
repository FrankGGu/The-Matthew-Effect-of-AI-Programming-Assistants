package main

func findMaximizedCapital(k int, w int, profits []int, capital []int) int {
    n := len(profits)
    projects := make([][2]int, n)
    for i := 0; i < n; i++ {
        projects[i] = [2]int{capital[i], profits[i]}
    }

    sort.Slice(projects, func(i, j int) bool {
        return projects[i][0] < projects[j][0]
    })

    maxHeap := &MaxHeap{}
    for i := 0; k > 0 && i <= n; i++ {
        if i < n && projects[i][0] <= w {
            heap.Push(maxHeap, projects[i][1])
            i++
        } else {
            if maxHeap.Len() == 0 {
                break
            }
            w += heap.Pop(maxHeap).(int)
            k--
        }
    }

    return w
}

type MaxHeap []int

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i] > h[j] }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
    *h = append(*h, x.(int))
}

func (h *MaxHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}