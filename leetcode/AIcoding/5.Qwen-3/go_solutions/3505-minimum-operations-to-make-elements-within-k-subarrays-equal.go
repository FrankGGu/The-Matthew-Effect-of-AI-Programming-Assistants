package main

func minOperations(nums []int, k int) int {
    n := len(nums)
    res := 0
    for i := 0; i < k; i++ {
        cnt := make(map[int]int)
        for j := i; j < n; j += k {
            cnt[nums[j]]++
        }
        maxFreq := 0
        for _, v := range cnt {
            if v > maxFreq {
                maxFreq = v
            }
        }
        res += (n/k - maxFreq)
    }
    return res
}