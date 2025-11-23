func arrayNesting(nums []int) int {
    maxLen := 0
    visited := make([]bool, len(nums))

    for i := 0; i < len(nums); i++ {
        if !visited[i] {
            start := nums[i]
            count := 0
            for {
                if visited[start] {
                    break
                }
                visited[start] = true
                start = nums[start]
                count++
            }
            if count > maxLen {
                maxLen = count
            }
        }
    }
    return maxLen
}