import "sort"

func canPartitionKSubsets(nums []int, k int) bool {
    totalSum := 0
    for _, num := range nums {
        totalSum += num
    }

    if totalSum%k != 0 {
        return false
    }

    targetSum := totalSum / k
    n