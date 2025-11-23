type Cashier struct {
    n         int
    discount  int
    count     int
    price     float64
}

func Constructor(n int, discount int, prices []int) Cashier {
    return Cashier{n: n, discount: discount, count: 0, price: 0}
}

func (this *Cashier) GetBill(count int, price int) float64 {
    this.count++
    this.price += float64(price * count)
    if this.count == this.n {
        this.price *= float64(1 - this.discount/100.0)
        this.count = 0
    }
    return this.price
}