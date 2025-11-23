func minimizeArrayLength(arr []int) int {
    n := len(arr)
    sort.Ints(arr)

    uniqueCount := 0
    sum := 0

    for i := n - 1; i >= 0; i-- {
        if sum + arr[i] > n {
            break
        }
        sum += arr[i]
        uniqueCount++
    }

    return uniqueCount
}