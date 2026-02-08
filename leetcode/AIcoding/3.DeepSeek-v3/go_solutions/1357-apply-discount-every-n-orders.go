type Cashier struct {
    n, discount, current int
    products map[int]int
}

func Constructor(n int, discount int, products []int, prices []int) Cashier {
    productMap := make(map[int]int)
    for i, product := range products {
        productMap[product] = prices[i]
    }
    return Cashier{
        n: n,
        discount: discount,
        current: 0,
        products: productMap,
    }
}

func (this *Cashier) GetBill(product []int, amount []int) float64 {
    this.current++
    total := 0
    for i, p := range product {
        total += this.products[p] * amount[i]
    }
    if this.current % this.n == 0 {
        return float64(total) * float64(100 - this.discount) / 100.0
    }
    return float64(total)
}