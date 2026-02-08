func minOperations(nums []int) int {
    n := len(nums)
    count := make([]int, n+1)
    for _, num := range nums {
        count[num]++
    }

    total := 0
    for i := 0; i < n; i++ {
        total += nums[i]
    }

    minOps := n
    for i := 0; i <= n; i++ {
        ops := total - count[i] + (n - count[i])
        if ops < minOps {
            minOps = ops
        }
    }

    return minOps
}