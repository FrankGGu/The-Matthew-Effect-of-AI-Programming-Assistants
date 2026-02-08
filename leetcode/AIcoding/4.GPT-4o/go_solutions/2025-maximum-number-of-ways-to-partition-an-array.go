func waysToPartition(nums []int, k int) int {
    n := len(nums)
    totalSum := 0
    for _, num := range nums {
        totalSum += num
    }

    leftSum := 0
    rightSum := totalSum
    count := 0
    prefixSum := make(map[int]int)

    for i := 0; i < n; i++ {
        leftSum += nums[i]
        rightSum -= nums[i]

        if leftSum == rightSum {
            count++
        }

        if i < n-1 {
            prefixSum[leftSum]++
            if prefixSum[leftSum+k] > 0 {
                count += prefixSum[leftSum+k]
            }
            if prefixSum[leftSum-k] > 0 {
                count += prefixSum[leftSum-k]
            }
        }
    }

    return count
}