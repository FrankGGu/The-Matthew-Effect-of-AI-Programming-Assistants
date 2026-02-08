func maximumSubarraySum(nums []int, k int) int64 {
    n := len(nums)
    if n < k {
        return 0
    }

    sum := int64(0)
    seen := make(map[int]int)
    maxSum := int64(0)

    for i := 0; i < k; i++ {
        num := nums[i]
        sum += int64(num)
        seen[num]++
    }

    if len(seen) == k {
        maxSum = sum
    }

    for i := k; i < n; i++ {
        removeNum := nums[i-k]
        addNum := nums[i]

        sum -= int64(removeNum)
        sum += int64(addNum)

        seen[removeNum]--
        if seen[removeNum] == 0 {
            delete(seen, removeNum)
        }
        seen[addNum]++

        if len(seen) == k {
            if sum > maxSum {
                maxSum = sum
            }
        }
    }

    return maxSum
}