package main

func minArrayLength(nums []int, queries []int) []int {
    n := len(nums)
    m := len(queries)
    res := make([]int, m)
    sort.Ints(nums)
    for i := 0; i < m; i++ {
        k := queries[i]
        cnt := 0
        for j := 0; j < n; j++ {
            if j+1 < n && nums[j+1]-nums[j] <= k {
                cnt++
                j++
            } else {
                cnt++
            }
        }
        res[i] = cnt
    }
    return res
}