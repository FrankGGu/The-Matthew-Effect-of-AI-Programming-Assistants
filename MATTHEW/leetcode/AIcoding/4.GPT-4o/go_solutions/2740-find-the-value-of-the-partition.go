func findValueOfPartition(nums []int) int {
    sort.Ints(nums)
    minDifference := math.MaxInt32
    for i := 1; i < len(nums); i++ {
        difference := nums[i] - nums[i-1]
        if difference < minDifference {
            minDifference = difference
        }
    }
    return minDifference
}