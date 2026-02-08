func totalMoney(n int) int {
    weeks := n / 7
    days := n % 7
    result := 0
    for i := 0; i < weeks; i++ {
        result += 28 + i*7
    }
    for i := 0; i < days; i++ {
        result += weeks + i + 1
    }
    return result
}