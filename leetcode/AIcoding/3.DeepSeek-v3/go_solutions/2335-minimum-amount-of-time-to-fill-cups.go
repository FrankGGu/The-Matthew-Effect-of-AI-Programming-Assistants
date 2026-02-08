func fillCups(amount []int) int {
    max := 0
    sum := 0
    for _, num := range amount {
        if num > max {
            max = num
        }
        sum += num
    }
    if max >= sum - max {
        return max
    }
    return (sum + 1) / 2
}