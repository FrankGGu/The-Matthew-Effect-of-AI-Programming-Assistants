package main

func canDistribute(nums []int, quantity []int) bool {
    freq := make(map[int]int)
    for _, num := range nums {
        freq[num]++
    }

    count := make([]int, 0)
    for _, f := range freq {
        count = append(count, f)
    }

    m := len(quantity)
    all := 1 << m
    sum := make([]int, all)
    for i := 1; i < all; i++ {
        for j := 0; j < m; j++ {
            if i & (1 << j) != 0 {
                sum[i] = sum[i ^ (1 << j)] + quantity[j]
                break
            }
        }
    }

    dp := make([]bool, all)
    dp[0] = true

    for _, c := range count {
        for s := all - 1; s >= 0; s-- {
            if !dp[s] {
                continue
            }
            for ns := 0; ns < all; ns++ {
                if s & ns == 0 && sum[ns] <= c {
                    dp[s | ns] = true
                }
            }
        }
    }

    return dp[all-1]
}