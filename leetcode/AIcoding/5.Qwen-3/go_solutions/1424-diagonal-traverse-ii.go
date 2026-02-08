package main

func findDiagonalOrder(nums []int) []int {
    m := len(nums)
    maxLevel := 0
    for i := 0; i < m; i++ {
        maxLevel = max(maxLevel, i+1)
    }
    result := make([]int, 0, m)
    for level := 0; level < maxLevel; level++ {
        for i := level; i >= 0; i-- {
            if i < m && len(nums[i]) > level-i {
                result = append(result, nums[i][level-i])
            }
        }
    }
    return result
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}