func getNumberOfBacklogOrders(orders [][]int) int {
    const mod = 1_000_000_007
    buy := [][]int{} // max heap
    sell := [][]int{} // min heap

    for _, order := range orders {
        price, amount, orderType := order[0], order[1], order[2]
        if orderType == 0 { // buy order
            heap.Push(&buy, []int{-price, amount})
        } else { // sell order
            heap.Push(&sell, []int{price, amount})
        }

        for len(buy) > 0 && len(sell) > 0 && -buy[0][0] >= sell[0][0] {
            buyAmount := buy[0][1]
            sellAmount := sell[0][1]
            if buyAmount > sellAmount {
                buy[0][1] -= sellAmount
                heap.Pop(&sell)
            } else if buyAmount < sellAmount {
                sell[0][1] -= buyAmount
                heap.Pop(&buy)
            } else {
                heap.Pop(&buy)
                heap.Pop(&sell)
            }
        }
    }

    total := 0
    for _, b := range buy {
        total = (total + b[1]) % mod
    }
    for _, s := range sell {
        total = (total + s[1]) % mod
    }
    return total
}

type IntHeap [][]int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i][0] < h[j][0] }
func (h IntHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *IntHeap) Push(x interface{}) {
    *h = append(*h, x.([]int))
}

func (h *IntHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}