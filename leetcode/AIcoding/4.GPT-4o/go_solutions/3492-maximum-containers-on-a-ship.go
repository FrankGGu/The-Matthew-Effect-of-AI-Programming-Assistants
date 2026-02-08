func maxContainers(A []int, K int) int {
    sort.Ints(A)
    count := 0
    for _, weight := range A {
        if K >= weight {
            K -= weight
            count++
        } else {
            break
        }
    }
    return count
}