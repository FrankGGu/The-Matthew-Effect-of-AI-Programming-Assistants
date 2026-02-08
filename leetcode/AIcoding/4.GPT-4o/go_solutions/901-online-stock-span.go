type StockSpanner struct {
    stack  []struct {
        price int
        span  int
    }
    day int
}

func Constructor() StockSpanner {
    return StockSpanner{stack: []struct {
        price int
        span  int
    }{}}
}

func (this *StockSpanner) Next(price int) int {
    this.day++
    span := 1
    for len(this.stack) > 0 && this.stack[len(this.stack)-1].price <= price {
        span += this.stack[len(this.stack)-1].span
        this.stack = this.stack[:len(this.stack)-1]
    }
    this.stack = append(this.stack, struct {
        price int
        span  int
    }{price: price, span: span})
    return span
}