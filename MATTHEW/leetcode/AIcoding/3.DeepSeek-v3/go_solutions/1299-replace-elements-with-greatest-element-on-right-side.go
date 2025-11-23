func replaceElements(arr []int) []int {
    maxRight := -1
    for i := len(arr) - 1; i >= 0; i-- {
        current := arr[i]
        arr[i] = maxRight
        if current > maxRight {
            maxRight = current
        }
    }
    return arr
}