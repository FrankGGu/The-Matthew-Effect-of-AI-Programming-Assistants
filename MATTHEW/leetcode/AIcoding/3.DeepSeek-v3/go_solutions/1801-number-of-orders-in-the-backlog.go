import (
	"container/heap"
)

type BuyHeap [][]int
func (h BuyHeap) Len() int { return len(h) }
func (h BuyHeap) Less(i, j int) bool { return h[i][0] > h[j][0] }
func (h BuyHeap) Swap(i, j int) { h[i], h[j] = h[j], h[i] }
func (h *BuyHeap) Push(x interface{}) { *h = append(*h, x.([]int)) }
func (h *BuyHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[:n-1]
	return x
}

type SellHeap [][]int
func (h SellHeap) Len() int { return len(h) }
func (h SellHeap) Less(i, j int) bool { return h[i][0] < h[j][0] }
func (h SellHeap) Swap(i, j int) { h[i], h[j] = h[j], h[i] }
func (h *SellHeap) Push(x interface{}) { *h = append(*h, x.([]int)) }
func (h *SellHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[:n-1]
	return x
}

func getNumberOfBacklogOrders(orders [][]int) int {
    buyHeap := &BuyHeap{}
    sellHeap := &SellHeap{}
    heap.Init(buyHeap)
    heap.Init(sellHeap)

    for _, order := range orders {
        price, amount, orderType := order[0], order[1], order[2]
        if orderType == 0 {
            for amount > 0 && sellHeap.Len() > 0 && (*sellHeap)[0][0] <= price {
                if (*sellHeap)[0][1] > amount {
                    (*sellHeap)[0][1] -= amount
                    amount = 0
                } else {
                    amount -= heap.Pop(sellHeap).([]int)[1]
                }
            }
            if amount > 0 {
                heap.Push(buyHeap, []int{price, amount})
            }
        } else {
            for amount > 0 && buyHeap.Len() > 0 && (*buyHeap)[0][0] >= price {
                if (*buyHeap)[0][1] > amount {
                    (*buyHeap)[0][1] -= amount
                    amount = 0
                } else {
                    amount -= heap.Pop(buyHeap).([]int)[1]
                }
            }
            if amount > 0 {
                heap.Push(sellHeap, []int{price, amount})
            }
        }
    }

    total := 0
    for _, order := range *buyHeap {
        total = (total + order[1]) % (1e9 + 7)
    }
    for _, order := range *sellHeap {
        total = (total + order[1]) % (1e9 + 7)
    }
    return total
}