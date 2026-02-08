func minimumSum(nums []int) int {
    n := len(nums)
    minSum := 1 << 31 - 1

    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            for k := j + 1; k < n; k++ {
                if nums[i] < nums[j] && nums[k] < nums[j] {
                    sum := nums[i] + nums[j] + nums[k]
                    if sum < minSum {
                        minSum = sum
                    }
                }
            }
        }
    }

    if minSum == 1<<31-1 {
        return -1
    }
    return minSum
}