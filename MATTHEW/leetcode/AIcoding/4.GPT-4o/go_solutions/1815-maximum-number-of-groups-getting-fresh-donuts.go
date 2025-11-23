func maxGroups(grumpy []int) int {
    n := len(grumpy)
    sum := 0
    for i := 1; i <= n; i++ {
        sum += i
        if sum > n {
            return i - 1
        }
    }
    return n
}