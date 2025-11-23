func minimumRemovals(arr []int) int {
    n := len(arr)
    lis := make([]int, n)
    lds := make([]int, n)

    for i := 0; i < n; i++ {
        lis[i] = 1
        for j := 0; j < i; j++ {
            if arr[j] < arr[i] {
                lis[i] = max(lis[i], lis[j]+1)
            }
        }
    }

    for i := n - 1; i >= 0; i-- {
        lds[i] = 1
        for j := n - 1; j > i; j-- {
            if arr[j] < arr[i] {
                lds[i] = max(lds[i], lds[j]+1)
            }
        }
    }

    maxMountain := 0
    for i := 0; i < n; i++ {
        if lis[i] > 1 && lds[i] > 1 {
            maxMountain = max(maxMountain, lis[i]+lds[i]-1)
        }
    }

    return n - maxMountain
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}