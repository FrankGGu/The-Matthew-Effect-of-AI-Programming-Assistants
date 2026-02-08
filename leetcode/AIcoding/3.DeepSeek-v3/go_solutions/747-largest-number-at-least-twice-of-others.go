func dominantIndex(nums []int) int {
    maxIndex := 0
    for i := range nums {
        if nums[i] > nums[maxIndex] {
            maxIndex = i
        }
    }
    for i := range nums {
        if i != maxIndex && nums[maxIndex] < 2 * nums[i] {
            return -1
        }
    }
    return maxIndex
}