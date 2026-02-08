func findX(arr []int, x int) int {
    for i, v := range arr {
        if v == x {
            return i
        }
    }
    return -1
}