import "container/heap"

type Order struct {
    price int
    amount int
}

type BuyHeap []Order

func (h BuyHeap) Len() int           { return len(h) }
func (h BuyHeap) Less(i, j int) bool { return h[i].price > h[j].price }
func (h BuyHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *BuyHeap) Push(x interface{}) {
    *h = append(*h, x.(Order))
}

func (h *BuyHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}

type SellHeap []Order

func (h SellHeap) Len() int           { return len(h) }
func (h SellHeap) Less(i, j int) bool { return h[i].price < h[j].price }
func (h SellHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *SellHeap) Push(x interface{}) {
    *h = append(*h, x.(Order))
}

func (h *SellHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}

const MOD = 1000000007

func getNumberOfBacklogOrders(orders [][]int) int {
    buyOrders := &BuyHeap{}
    heap.Init(buyOrders)
    sellOrders := &SellHeap{}
    heap.Init(sellOrders)

    for _, order := range orders {
        price := order[0]
        amount := order[1]
        orderType := order[2]

        if orderType == 0 { // Buy order
            for amount > 0 && sellOrders.Len() > 0 && (*sellOrders)[0].price <= price {
                topSell := heap.Pop(sellOrders).(Order)
                if topSell.amount <= amount {
                    amount -= topSell.amount
                } else {
                    topSell.amount -= amount
                    amount = 0
                    heap.Push(sellOrders, topSell)
                }
            }
            if amount > 0 {
                heap.Push(buyOrders, Order{price: price, amount: amount})
            }
        } else { // Sell order
            for amount > 0 && buyOrders.Len() > 0 && (*buyOrders)[0].price >= price {
                topBuy := heap.Pop(buyOrders).(Order)
                if topBuy.amount <= amount {
                    amount -= topBuy.amount
                } else {
                    topBuy.amount -= amount
                    amount = 0
                    heap.Push(buyOrders, topBuy)
                }
            }
            if amount > 0 {
                heap.Push(sellOrders, Order{price: price, amount: amount})
            }
        }
    }

    totalOrders := 0
    for buyOrders.Len() > 0 {
        order := heap.Pop(buyOrders).(Order)
        totalOrders = (totalOrders + order.amount) % MOD
    }
    for sellOrders.Len() > 0 {
        order := heap.Pop(sellOrders).(Order)
        totalOrders = (totalOrders + order.amount) % MOD
    }

    return totalOrders
}