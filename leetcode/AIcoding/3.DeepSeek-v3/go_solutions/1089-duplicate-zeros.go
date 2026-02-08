func duplicateZeros(arr []int) {
    n := len(arr)
    zeros := 0
    for _, num := range arr {
        if num == 0 {
            zeros++
        }
    }
    for i := n - 1; i >= 0; i-- {
        if i + zeros < n {
            arr[i + zeros] = arr[i]
        }
        if arr[i] == 0 {
            zeros--
            if i + zeros < n {
                arr[i + zeros] = 0
            }
        }
    }
}