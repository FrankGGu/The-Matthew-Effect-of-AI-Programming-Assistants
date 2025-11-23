func minPlatforms(arr []int, dep []int, n int) int {
    sort.Ints(arr)
    sort.Ints(dep)

    platforms := 0
    result := 0
    i, j := 0, 0

    for i < n && j < n {
        if arr[i] <= dep[j] {
            platforms++
            i++
            if platforms > result {
                result = platforms
            }
        } else {
            platforms--
            j++
        }
    }
    return result
}