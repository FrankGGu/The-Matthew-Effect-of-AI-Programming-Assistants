type Cashier struct {
    n int
    discount int
    products map[int]int
    count int
}

func Constructor(n int, discount int, products []int, prices []int) Cashier {
    m := make(map[int]int)
    for i := 0; i < len(products); i++ {
        m[products[i]] = prices[i]
    }
    return Cashier{
        n: n,
        discount: discount,
        products: m,
        count: 0,
    }
}

func (this *Cashier) GetBill(product []int, amount []int) float64 {
    this.count++
    total := 0.0
    for i := 0; i < len(product); i++ {
        total += float64(this.products[product[i]] * amount[i])
    }
    if this.count % this.n == 0 {
        total *= (1.0 - float64(this.discount) / 100.0)
    }
    return total
}