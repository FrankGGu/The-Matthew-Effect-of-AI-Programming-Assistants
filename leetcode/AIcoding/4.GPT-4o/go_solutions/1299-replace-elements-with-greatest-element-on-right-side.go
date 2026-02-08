func replaceElements(arr []int) []int {
    n := len(arr)
    maxFromRight := -1
    for i := n - 1; i >= 0; i-- {
        current := arr[i]
        arr[i] = maxFromRight
        if current > maxFromRight {
            maxFromRight = current
        }
    }
    return arr
}