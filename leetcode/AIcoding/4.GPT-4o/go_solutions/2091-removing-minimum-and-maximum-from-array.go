func minimumDeletions(nums []int) int {
    minIndex, maxIndex := 0, 0
    for i, num := range nums {
        if num < nums[minIndex] {
            minIndex = i
        }
        if num > nums[maxIndex] {
            maxIndex = i
        }
    }

    return 1 + min(minIndex, maxIndex) + len(nums) - max(minIndex, maxIndex) - 1
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}