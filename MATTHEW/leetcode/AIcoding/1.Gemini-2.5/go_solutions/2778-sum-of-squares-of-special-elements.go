func sumOfSquares(nums []int) int {
    n := len(nums)
    totalSum := 0
    for i := 0; i < n; i++ {
        if n%(i+1) == 0 {
            totalSum += nums[i] * nums[i]
        }
    }
    return totalSum
}