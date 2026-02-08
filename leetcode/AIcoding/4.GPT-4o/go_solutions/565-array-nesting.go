func arrayNesting(nums []int) int {
    maxLen := 0
    visited := make([]bool, len(nums))

    for i := 0; i < len(nums); i++ {
        if !visited[i] {
            count := 0
            j := i
            for !visited[j] {
                visited[j] = true
                j = nums[j]
                count++
            }
            if count > maxLen {
                maxLen = count
            }
        }
    }
    return maxLen
}