func replaceElements(arr []int) []int {
    maxRight := -1
    for i := len(arr) - 1; i >= 0; i-- {
        temp := arr[i]
        arr[i] = maxRight
        if temp > maxRight {
            maxRight = temp
        }
    }
    return arr
}