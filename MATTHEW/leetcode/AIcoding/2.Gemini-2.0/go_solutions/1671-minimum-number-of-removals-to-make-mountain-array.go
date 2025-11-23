func minimumMountainRemovals(nums []int) int {
    n := len(nums)
    if n < 3 {
        return 0
    }

    lis := make([]int, n)
    lds := make([]int, n)

    for i := 0; i < n; i++ {
        lis[i] = 1
        for j := 0; j < i; j++ {
            if nums[i] > nums[j] {
                lis[i] = max(lis[i], lis[j]+1)
            }
        }
    }

    for i := n - 1; i >= 0; i-- {
        lds[i] = 1
        for j := n - 1; j > i; j-- {
            if nums[i] > nums[j] {
                lds[i] = max(lds[i], lds[j]+1)
            }
        }
    }

    ans := 0
    for i := 0; i < n; i++ {
        if lis[i] > 1 && lds[i] > 1 {
            ans = max(ans, lis[i]+lds[i]-1)
        }
    }

    return n - ans
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}