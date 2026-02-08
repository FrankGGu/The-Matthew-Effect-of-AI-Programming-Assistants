func finalPrices(prices []int) []int {
    stack := []int{}
    res := make([]int, len(prices))
    copy(res, prices)
    for i := 0; i < len(prices); i++ {
        for len(stack) > 0 && prices[stack[len(stack)-1]] >= prices[i] {
            idx := stack[len(stack)-1]
            res[idx] = prices[idx] - prices[i]
            stack = stack[:len(stack)-1]
        }
        stack = append(stack, i)
    }
    return res
}