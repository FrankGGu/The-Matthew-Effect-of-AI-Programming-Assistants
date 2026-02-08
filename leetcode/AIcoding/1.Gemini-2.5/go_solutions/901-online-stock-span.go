type StockSpanner struct {
    stack [][]int // Stores pairs of [price, span]
}

func Constructor() StockSpanner {
    return StockSpanner{
        stack: make([][]int, 0),
    }
}

func (this *StockSpanner) Next(price int) int {
    span := 1
    // While the stack is not empty and the current price is greater than or equal to the price at the top of the stack
    for len(this.stack) > 0 && this.stack[len(this.stack)-1][0] <=