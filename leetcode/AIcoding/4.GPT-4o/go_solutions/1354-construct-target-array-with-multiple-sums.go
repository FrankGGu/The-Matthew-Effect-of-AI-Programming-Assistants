func isPossible(target []int) bool {
    total := 0
    maxHeap := &MaxHeap{}

    for _, num := range target {
        total += num
        maxHeap.Push(num)
    }

    for maxHeap.Peek() != 1 {
        max := maxHeap.Pop()
        total -= max

        if total <= 0 || total >= max {
            return false
        }

        newNum := max % total
        if newNum == 0 {
            return false
        }

        total += newNum
        maxHeap.Push(newNum)
    }
    return true
}

type MaxHeap []int

func (h *MaxHeap) Push(x int) {
    *h = append(*h, x)
    h.up(len(*h) - 1)
}

func (h *MaxHeap) Pop() int {
    n := len(*h) - 1
    *h[0], *h[n] = *h[n], *h[0]
    val := (*h)[n]
    *h = (*h)[:n]
    h.down(0, n-1)
    return val
}

func (h *MaxHeap) Peek() int {
    return (*h)[0]
}

func (h *MaxHeap) up(i int) {
    for i > 0 {
        parent := (i - 1) / 2
        if (*h)[parent] >= (*h)[i] {
            break
        }
        (*h)[parent], (*h)[i] = (*h)[i], (*h)[parent]
        i = parent
    }
}

func (h *MaxHeap) down(i, n int) {
    for {
        left := 2*i + 1
        if left > n {
            break
        }
        largest := left
        if right := left + 1; right <= n && (*h)[right] > (*h)[left] {
            largest = right
        }
        if (*h)[i] >= (*h)[largest] {
            break
        }
        (*h)[i], (*h)[largest] = (*h)[largest], (*h)[i]
        i = largest
    }
}