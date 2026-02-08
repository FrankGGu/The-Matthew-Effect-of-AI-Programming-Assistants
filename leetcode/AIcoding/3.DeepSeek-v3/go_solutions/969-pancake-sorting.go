func pancakeSort(arr []int) []int {
    res := []int{}
    n := len(arr)
    for x := n; x > 0; x-- {
        i := 0
        for arr[i] != x {
            i++
        }
        if i != 0 {
            reverse(arr, i+1)
            res = append(res, i+1)
        }
        reverse(arr, x)
        res = append(res, x)
    }
    return res
}

func reverse(arr []int, k int) {
    for i, j := 0, k-1; i < j; i, j = i+1, j-1 {
        arr[i], arr[j] = arr[j], arr[i]
    }
}