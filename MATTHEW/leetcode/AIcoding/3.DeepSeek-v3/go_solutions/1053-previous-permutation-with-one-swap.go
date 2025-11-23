func prevPermOpt1(arr []int) []int {
    n := len(arr)
    for i := n - 2; i >= 0; i-- {
        if arr[i] > arr[i+1] {
            maxVal, maxIdx := -1, -1
            for j := i + 1; j < n; j++ {
                if arr[j] < arr[i] && arr[j] > maxVal {
                    maxVal = arr[j]
                    maxIdx = j
                }
            }
            if maxIdx != -1 {
                arr[i], arr[maxIdx] = arr[maxIdx], arr[i]
                return arr
            }
        }
    }
    return arr
}