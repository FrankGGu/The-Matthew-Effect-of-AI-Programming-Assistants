import "sort"

func minPairSum(nums []int) int {
    sort.Ints(nums)
    maxSum := 0
    n := len(nums)
    for i := 0; i < n/2; i++ {
        currentSum := nums[i] + nums[n-1-i]
        if currentSum > maxSum {
            maxSum = currentSum
        }
    }
    return maxSum
}