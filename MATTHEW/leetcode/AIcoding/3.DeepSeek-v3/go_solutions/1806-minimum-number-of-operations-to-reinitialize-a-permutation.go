func reinitializePermutation(n int) int {
    perm := make([]int, n)
    for i := range perm {
        perm[i] = i
    }
    arr := make([]int, n)
    copy(arr, perm)
    res := 0
    for {
        res++
        temp := make([]int, n)
        for i := 0; i < n; i++ {
            if i%2 == 0 {
                temp[i] = arr[i/2]
            } else {
                temp[i] = arr[n/2 + (i-1)/2]
            }
        }
        arr = temp
        same := true
        for i := 0; i < n; i++ {
            if arr[i] != perm[i] {
                same = false
                break
            }
        }
        if same {
            break
        }
    }
    return res
}