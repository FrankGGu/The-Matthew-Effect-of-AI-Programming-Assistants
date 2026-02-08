package main

func markElements(nums []int, queries []int) []int {
    n := len(nums)
    res := make([]int, n)
    for i := range res {
        res[i] = -1
    }
    for _, q := range queries {
        for i := 0; i < n; i++ {
            if nums[i] == q && res[i] == -1 {
                res[i] = q
                break
            }
        }
    }
    return res
}