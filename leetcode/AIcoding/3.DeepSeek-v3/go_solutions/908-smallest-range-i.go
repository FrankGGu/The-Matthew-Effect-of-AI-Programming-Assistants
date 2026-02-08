func smallestRangeI(nums []int, k int) int {
    minNum := nums[0]
    maxNum := nums[0]
    for _, num := range nums {
        if num < minNum {
            minNum = num
        }
        if num > maxNum {
            maxNum = num
        }
    }
    diff := maxNum - minNum - 2*k
    if diff < 0 {
        return 0
    }
    return diff
}