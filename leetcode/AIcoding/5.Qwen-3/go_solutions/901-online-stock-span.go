package main

type StockSpanner struct {
    stack [][2]int
}

func Constructor() StockSpanner {
    return StockSpanner{}
}

func (s *StockSpanner) Next(price int) int {
    span := 1
    for len(s.stack) > 0 && s.stack[len(s.stack)-1][0] <= price {
        span += s.stack[len(s.stack)-1][1]
        s.stack = s.stack[:len(s.stack)-1]
    }
    s.stack = append(s.stack, [2]int{price, span})
    return span
}