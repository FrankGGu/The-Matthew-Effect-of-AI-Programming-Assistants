type Cashier struct {
    product  map[int]int
    price    map[int]float64
    total    float64
    discount  float64
    count    int
}

func Constructor(products [][]int, prices []float64, discount int, n int) Cashier {
    p := make(map[int]int)
    pr := make(map[int]float64)
    for i := 0; i < len(products); i++ {
        p[products[i][0]] = products[i][1]
        pr[products[i][0]] = prices[i]
    }
    return Cashier{product: p, price: pr, total: float64(n), discount: float64(discount), count: 0}
}

func (this *Cashier) GetBill(product []int, amount []int) float64 {
    total := 0.0
    for i := 0; i < len(product); i++ {
        total += this.price[product[i]] * float64(amount[i])
    }
    this.count += 1
    if this.count%this.total == 0 {
        total *= (100 - this.discount) / 100
    }
    return total
}