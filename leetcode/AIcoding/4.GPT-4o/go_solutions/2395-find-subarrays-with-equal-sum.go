func findSubarrays(nums []int) bool {
    sumMap := make(map[int]bool)
    currentSum := 0

    for i := 0; i < len(nums)-1; i++ {
        currentSum = nums[i] + nums[i+1]
        if sumMap[currentSum] {
            return true
        }
        sumMap[currentSum] = true
    }
    return false
}