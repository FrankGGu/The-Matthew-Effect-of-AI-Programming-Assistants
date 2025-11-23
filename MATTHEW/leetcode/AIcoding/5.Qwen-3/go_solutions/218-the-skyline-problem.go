package main

func getSkyline(prices [][]int) [][]int {
    var result [][]int
    if len(prices) == 0 {
        return result
    }
    n := len(prices)
    points := make([][3]int, 2*n)
    for i := 0; i < n; i++ {
        points[2*i] = [3]int{prices[i][0], -prices[i][2], 0}
        points[2*i+1] = [3]int{prices[i][1], prices[i][2], 1}
    }
    sort.Slice(points, func(i, j int) bool {
        if points[i][0] != points[j][0] {
            return points[i][0] < points[j][0]
        }
        if points[i][1] != points[j][1] {
            return points[i][1] < points[j][1]
        }
        return points[i][2] < points[j][2]
    })
    var prevHeight int
    var currHeight int
    heap := &IntHeap{}
    for i := 0; i < len(points); i++ {
        if points[i][2] == 0 {
            heappush(heap, points[i][1])
        } else {
            heappop(heap, points[i][1])
        }
        currHeight = 0
        if heap.Len() > 0 {
            currHeight = (*heap)[0]
        }
        if currHeight != prevHeight {
            result = append(result, []int{points[i][0], currHeight})
            prevHeight = currHeight
        }
    }
    return result
}

type IntHeap []int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i] < h[j] }
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

func heappush(h *IntHeap, x int) {
    heap.Push(h, x)
}

func heappop(h *IntHeap, x int) {
    for i := 0; i < len(*h); i++ {
        if (*h)[i] == x {
            heap.Remove(h, i)
            return
        }
    }
}