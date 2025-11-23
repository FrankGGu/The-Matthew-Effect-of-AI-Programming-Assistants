package main

func canPartitionKSubsets(nums []int, k int) bool {
    total := 0
    for _, num := range nums {
        total += num
    }
    if total%k != 0 {
        return false
    }
    target := total / k
    sort.Ints(nums)
    if nums[len(nums)-1] > target {
        return false
    }
    used := make([]bool, len(nums))
    var backtrack func(int, int) bool
    backtrack = func(start int, currentSum int) bool {
        if currentSum == target {
            return backtrack(0, 0)
        }
        for i := start; i < len(nums); i++ {
            if used[i] || currentSum+nums[i] > target {
                continue
            }
            used[i] = true
            if backtrack(i+1, currentSum+nums[i]) {
                return true
            }
            used[i] = false
        }
        return false
    }
    return backtrack(0, 0)
}