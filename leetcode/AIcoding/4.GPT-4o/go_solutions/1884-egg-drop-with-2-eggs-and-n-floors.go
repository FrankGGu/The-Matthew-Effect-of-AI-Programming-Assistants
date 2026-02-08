func twoEggDrop(n int) int {
    k := 0
    sum := 0
    for sum < n {
        k++
        sum += k
    }
    return k
}