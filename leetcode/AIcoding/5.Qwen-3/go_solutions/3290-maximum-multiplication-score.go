package main

func maximumScore(a int, b int, nums []int) int {
    mod := 1000000007
    sort.Ints(nums)
    n := len(nums)
    maxScore := 0
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            score := (a - nums[i]) * (b - nums[j])
            if score > maxScore {
                maxScore = score
            }
        }
    }
    return maxScore % mod
}