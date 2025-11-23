func transformArray(arr []int) []int {
    n := len(arr)
    result := make([]int, n)
    copy(result, arr)

    for i := 0; i < n; i++ {
        if arr[i]%2 == 0 {
            if i > 0 && arr[i-1]%2 == 1 {
                result[i]++
            }
            if i < n-1 && arr[i+1]%2 == 1 {
                result[i]++
            }
        } else {
            if i > 0 && arr[i-1]%2 == 0 {
                result[i]--
            }
            if i < n-1 && arr[i+1]%2 == 0 {
                result[i]--
            }
        }
    }

    return result
}