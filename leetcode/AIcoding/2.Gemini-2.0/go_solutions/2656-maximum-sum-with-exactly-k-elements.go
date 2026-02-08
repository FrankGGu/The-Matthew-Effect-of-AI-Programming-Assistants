func maximizeSum(nums []int, k int) int {
    maxVal := 0
    for _, num := range nums {
        if num > maxVal {
            maxVal = num
        }
    }
    return maxVal * k + k * (k - 1) / 2
}