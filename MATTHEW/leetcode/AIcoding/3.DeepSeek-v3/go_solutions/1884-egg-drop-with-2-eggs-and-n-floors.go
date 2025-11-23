func twoEggDrop(n int) int {
    k := 1
    for k*(k+1)/2 < n {
        k++
    }
    return k
}