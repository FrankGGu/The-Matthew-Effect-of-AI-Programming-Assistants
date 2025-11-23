func countElements(nums []int) int {
    if len(nums) <= 2 {
        return 0
    }
    minVal, maxVal := nums[0], nums[0]
    for _, num := range nums {
        if num < minVal {
            minVal = num
        }
        if num > maxVal {
            maxVal = num
        }
    }
    count := 0
    for _, num := range nums {
        if num > minVal && num < maxVal {
            count++
        }
    }
    return count
}