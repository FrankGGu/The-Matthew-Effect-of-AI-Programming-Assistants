func findX(arr []int) int {
    x := 0
    for _, num := range arr {
        x ^= num
    }
    return x
}