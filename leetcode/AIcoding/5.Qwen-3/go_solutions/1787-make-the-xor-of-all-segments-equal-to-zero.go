package main

func minChanges(nums []int, k int) int {
    cnt := make([]int, 1<<k)
    for _, num := range nums {
        for i := 0; i < 1<<k; i++ {
            cnt[i] = 0
        }
        for i := 0; i < 1<<k; i++ {
            cnt[i^num] += 1
        }
        for i := 0; i < 1<<k; i++ {
            if cnt[i] > 0 {
                cnt[i] = 1
            }
        }
    }
    res := 0
    for i := 0; i < 1<<k; i++ {
        if cnt[i] == 0 {
            res++
        }
    }
    return res
}