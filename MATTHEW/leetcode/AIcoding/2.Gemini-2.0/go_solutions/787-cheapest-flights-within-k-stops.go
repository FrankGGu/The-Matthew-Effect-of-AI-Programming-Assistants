func findCheapestPrice(n int, flights [][]int, src int, dst int, k int) int {
    prices := make([]int, n)
    for i := range prices {
        prices[i] = 1000000000
    }
    prices[src] = 0

    for i := 0; i <= k; i++ {
        temp := make([]int, n)
        copy(temp, prices)
        for _, flight := range flights {
            s, d, p := flight[0], flight[1], flight[2]
            if prices[s] != 1000000000 && prices[s]+p < temp[d] {
                temp[d] = prices[s] + p
            }
        }
        prices = temp
    }

    if prices[dst] == 1000000000 {
        return -1
    }
    return prices[dst]
}