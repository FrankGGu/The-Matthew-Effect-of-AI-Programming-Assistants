func minOperations(arr []int, k int) int {
    n := len(arr)
    if k == 0 {
        return 0
    }

    dp := make([][]int, k)
    for i := 0; i < k; i++ {
        dp[i] = []int{}
    }

    for i := 0; i < n; i++ {
        dp[i%k] = append(dp[i%k], arr[i])
    }

    operations := 0
    for i := 0; i < k; i++ {
        operations += len(dp[i]) - lengthOfLIS(dp[i])
    }

    return operations
}

func lengthOfLIS(nums []int) int {
    if len(nums) == 0 {
        return 0
    }
    lis := []int{}
    for _, num := range nums {
        pos := lowerBound(lis, num)
        if pos == len(lis) {
            lis = append(lis, num)
        } else {
            lis[pos] = num
        }
    }
    return len(lis)
}

func lowerBound(nums []int, target int) int {
    left, right := 0, len(nums)
    for left < right {
        mid := left + (right-left)/2
        if nums[mid] < target {
            left = mid + 1
        } else {
            right = mid
        }
    }
    return left
}