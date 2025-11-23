func minOperations(nums []int, k int) int {
    total := 0
    for _, num := range nums {
        total += num
    }
    remainder := total % k
    if remainder == 0 {
        return 0
    }
    n := len(nums)
    minOps := n + 1
    prefixSum := 0
    prefixCount := map[int]int{0: -1}

    for i := 0; i < n; i++ {
        prefixSum += nums[i]
        if idx, exists := prefixCount[(prefixSum-remainder+k)%k]; exists {
            minOps = min(minOps, i-idx)
        }
        prefixCount[prefixSum%k] = i
    }
    if minOps == n + 1 {
        return -1
    }
    return minOps
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}