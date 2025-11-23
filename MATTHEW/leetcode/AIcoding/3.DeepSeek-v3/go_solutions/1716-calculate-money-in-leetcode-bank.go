func totalMoney(n int) int {
    weeks := n / 7
    days := n % 7
    total := 0

    total += 28 * weeks
    total += 7 * weeks * (weeks - 1) / 2

    start := weeks + 1
    for i := 0; i < days; i++ {
        total += start + i
    }

    return total
}