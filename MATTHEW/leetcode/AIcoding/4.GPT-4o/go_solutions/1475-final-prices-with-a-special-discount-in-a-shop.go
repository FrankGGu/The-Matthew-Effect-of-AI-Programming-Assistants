func finalPrices(prices []int) []int {
    n := len(prices)
    result := make([]int, n)
    copy(result, prices)

    stack := []int{}
    for i := 0; i < n; i++ {
        for len(stack) > 0 && prices[stack[len(stack)-1]] >= prices[i] {
            j := stack[len(stack)-1]
            result[j] -= prices[i]
            stack = stack[:len(stack)-1]
        }
        stack = append(stack, i)
    }
    return result
}