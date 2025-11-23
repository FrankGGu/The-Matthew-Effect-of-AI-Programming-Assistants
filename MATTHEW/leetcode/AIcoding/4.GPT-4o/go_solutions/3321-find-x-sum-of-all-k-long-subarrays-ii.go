func xSum(nums []int, k int, x int) int64 {
    n := len(nums)
    if n < k {
        return 0
    }

    sum := int64(0)
    currentSum := int64(0)

    for i := 0; i < k; i++ {
        currentSum += int64(nums[i])
    }

    if currentSum == int64(x) {
        sum++
    }

    for i := k; i < n; i++ {
        currentSum += int64(nums[i]) - int64(nums[i-k])
        if currentSum == int64(x) {
            sum++
        }
    }

    return sum
}