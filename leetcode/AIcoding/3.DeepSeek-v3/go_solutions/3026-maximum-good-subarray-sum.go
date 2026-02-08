func maximumSubarraySum(nums []int, k int) int64 {
    prefixSum := make([]int64, len(nums)+1)
    for i := 0; i < len(nums); i++ {
        prefixSum[i+1] = prefixSum[i] + int64(nums[i])
    }

    minIndices := make(map[int]int)
    maxSum := int64(-1 << 63)

    for i := 0; i < len(nums); i++ {
        target1 := nums[i] - k
        target2 := nums[i] + k

        if idx, ok := minIndices[target1]; ok {
            sum := prefixSum[i+1] - prefixSum[idx]
            if sum > maxSum {
                maxSum = sum
            }
        }
        if idx, ok := minIndices[target2]; ok {
            sum := prefixSum[i+1] - prefixSum[idx]
            if sum > maxSum {
                maxSum = sum
            }
        }

        if _, ok := minIndices[nums[i]]; !ok || prefixSum[i] < prefixSum[minIndices[nums[i]]] {
            minIndices[nums[i]] = i
        }
    }

    if maxSum == int64(-1 << 63) {
        return 0
    }
    return maxSum
}