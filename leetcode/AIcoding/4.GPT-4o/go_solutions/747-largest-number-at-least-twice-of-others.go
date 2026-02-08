func dominantIndex(nums []int) int {
    maxIdx, maxVal := 0, nums[0]
    for i := 1; i < len(nums); i++ {
        if nums[i] > maxVal {
            maxVal = nums[i]
            maxIdx = i
        }
    }
    for i := 0; i < len(nums); i++ {
        if i != maxIdx && nums[i] * 2 > maxVal {
            return -1
        }
    }
    return maxIdx
}