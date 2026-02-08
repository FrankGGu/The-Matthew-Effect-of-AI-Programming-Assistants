func minimumSum(nums []int) int {
    n := len(nums)
    if n < 3 {
        return -1
    }

    leftMin := make([]int, n)
    leftMin[0] = nums[0]
    for i := 1; i < n; i++ {
        leftMin[i] = min(leftMin[i-1], nums[i])
    }

    rightMin := make([]int, n)
    rightMin[n-1] = nums[n-1]
    for i := n-2; i >= 0; i-- {
        rightMin[i] = min(rightMin[i+1], nums[i])
    }

    res := math.MaxInt32
    for j := 1; j < n-1; j++ {
        if leftMin[j-1] < nums[j] && rightMin[j+1] < nums[j] {
            sum := leftMin[j-1] + nums[j] + rightMin[j+1]
            if sum < res {
                res = sum
            }
        }
    }

    if res == math.MaxInt32 {
        return -1
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}