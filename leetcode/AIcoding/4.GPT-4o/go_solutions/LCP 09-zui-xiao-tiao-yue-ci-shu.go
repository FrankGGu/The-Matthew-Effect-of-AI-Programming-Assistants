func jump(nums []int) int {
    jumps := 0
    currentEnd := 0
    farthest := 0
    for i := 0; i < len(nums)-1; i++ {
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