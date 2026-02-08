func jump(nums []int) int {
    n := len(nums)
    if n <= 1 {
        return 0
    }
    jumps := 0
    currentEnd := 0
    farthest := 0

    for i := 0; i < n-1; i++ {
        farthest = max(farthest, i+nums[i])
        if i == currentEnd {
            jumps++
            currentEnd = farthest
        }
    }
    return jumps
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}