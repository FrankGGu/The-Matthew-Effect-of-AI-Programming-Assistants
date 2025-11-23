func smallestIndex(nums []int) int {
    for i := 0; i < len(nums); i++ {
        sum := 0
        for j := 0; j <= i; j++ {
            sum += nums[j]
        }
        if sum == i {
            return i
        }
    }
    return -1
}