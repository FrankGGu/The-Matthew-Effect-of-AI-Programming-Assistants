func maximumUniqueSubarray(nums []int) int {
    left := 0
    maxSum := 0
    currentSum := 0
    seen := make(map[int]int)

    for right := 0; right < len(nums); right++ {
        num := nums[right]
        if pos, exists := seen[num]; exists && pos >= left {
            for left <= pos {
                currentSum -= nums[left]
                left++
            }
        }
        seen[num] = right
        currentSum += num
        if currentSum > maxSum {
            maxSum = currentSum
        }
    }
    return maxSum
}