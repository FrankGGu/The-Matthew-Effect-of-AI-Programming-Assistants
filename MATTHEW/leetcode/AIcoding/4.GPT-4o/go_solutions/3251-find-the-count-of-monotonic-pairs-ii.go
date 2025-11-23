func countMonotonicPairs(nums []int) int64 {
    n := len(nums)
    if n < 2 {
        return 0
    }
    result := int64(0)
    leftCount := make([]int64, n)
    rightCount := make([]int64, n)

    for i := 0; i < n; i++ {
        if i == 0 {
            leftCount[i] = 1
        } else if nums[i] >= nums[i-1] {
            leftCount[i] = leftCount[i-1] + 1
        } else {
            leftCount[i] = 1
        }
    }

    for i := n - 1; i >= 0; i-- {
        if i == n-1 {
            rightCount[i] = 1
        } else if nums[i] <= nums[i+1] {
            rightCount[i] = rightCount[i+1] + 1
        } else {
            rightCount[i] = 1
        }
    }

    for i := 0; i < n; i++ {
        result += leftCount[i] * rightCount[i]
    }

    return result - int64(n)
}