func getXSum(nums []int, k int) int {
    n := len(nums)
    xSum := 0
    for i := 0; i <= n-k; i++ {
        subarray := nums[i : i+k]
        minVal := subarray[0]
        maxVal := subarray[0]
        for _, num := range subarray {
            if num < minVal {
                minVal = num
            }
            if num > maxVal {
                maxVal = num
            }
        }
        xSum += minVal + maxVal
    }
    return xSum
}