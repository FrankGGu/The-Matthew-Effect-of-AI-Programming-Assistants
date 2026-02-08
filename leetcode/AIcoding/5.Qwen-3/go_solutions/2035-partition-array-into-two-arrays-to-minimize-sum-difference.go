package main

func minimumIncompatibility(nums []int, k int) int {
    n := len(nums)
    if k == n {
        return 0
    }
    if k == 1 {
        return sum(nums)
    }

    sort.Ints(nums)

    dp := make([]int, 1<<n)
    for i := range dp {
        dp[i] = math.MaxInt32
    }
    dp[0] = 0

    for mask := 0; mask < (1 << n); mask++ {
        if dp[mask] == math.MaxInt32 {
            continue
        }

        count := 0
        for i := 0; i < n; i++ {
            if mask&(1<<i) != 0 {
                count++
            }
        }

        if count == k {
            continue
        }

        for i := 0; i < n; i++ {
            if mask&(1<<i) != 0 {
                continue
            }

            newMask := mask | (1 << i)
            if dp[newMask] > dp[mask] {
                dp[newMask] = dp[mask]
            }

            for j := i + 1; j < n; j++ {
                if newMask&(1<<j) != 0 {
                    continue
                }

                newMask2 := newMask | (1 << j)
                if dp[newMask2] > dp[mask]+abs(nums[i]-nums[j]) {
                    dp[newMask2] = dp[mask] + abs(nums[i]-nums[j])
                }
            }
        }
    }

    if dp[(1<<n)-1] == math.MaxInt32 {
        return -1
    }
    return dp[(1<<n)-1]
}

func sum(nums []int) int {
    s := 0
    for _, v := range nums {
        s += v
    }
    return s
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}