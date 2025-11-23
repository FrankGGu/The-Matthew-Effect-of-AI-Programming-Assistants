func pancakeSort(arr []int) []int {
    res := []int{}
    n := len(arr)

    for i := n; i > 1; i-- {
        maxIdx := 0
        for j := 1; j < i; j++ {
            if arr[j] > arr[maxIdx] {
                maxIdx = j
            }
        }
        if maxIdx != i-1 {
            if maxIdx > 0 {
                res = append(res, maxIdx+1)
                reverse(arr, maxIdx+1)
            }
            res = append(res, i)
            reverse(arr, i)
        }
    }
    return res
}

func reverse(arr []int, k int) {
    for i, j := 0, k-1; i < j; i, j = i+1, j-1 {
        arr[i], arr[j] = arr[j], arr[i]
    }
}