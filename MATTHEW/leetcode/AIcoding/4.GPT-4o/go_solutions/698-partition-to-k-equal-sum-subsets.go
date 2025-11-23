func canPartitionKSubsets(nums []int, k int) bool {
    totalSum := 0
    for _, num := range nums {
        totalSum += num
    }
    if totalSum%k != 0 {
        return false
    }
    target := totalSum / k
    used := make([]bool, len(nums))
    return backtrack(nums, used, 0, 0, k, target)
}

func backtrack(nums []int, used []bool, start int, currentSum int, k int, target int) bool {
    if k == 1 {
        return true
    }
    if currentSum == target {
        return backtrack(nums, used, 0, 0, k-1, target)
    }
    for i := start; i < len(nums); i++ {
        if used[i] || currentSum+nums[i] > target {
            continue
        }
        used[i] = true
        if backtrack(nums, used, i+1, currentSum+nums[i], k, target) {
            return true
        }
        used[i] = false
    }
    return false
}