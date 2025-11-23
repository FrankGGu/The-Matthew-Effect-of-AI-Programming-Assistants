func findXValueOfArray(arr []int, x int) int {
    n := len(arr)
    if x < 0 || x >= n {
        return -1
    }
    return arr[x]
}