func maxSumMinProduct(nums []int) int {
    n := len(nums)
    mod := int(1e9 + 7)

    prefixSum := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefixSum[i+1] = (prefixSum[i] + nums[i]) % mod
    }

    stack := []int{}
    maxProduct := 0

    for i := 0; i <= n; i++ {
        current := 0
        if i < n {
            current = nums[i]
        }

        for len(stack) > 0 && (i == n || nums[stack[len(stack)-1]] > current) {
            j := stack[len(stack)-1]
            stack = stack[:len(stack)-1]
            left := -1
            if len(stack) > 0 {
                left = stack[len(stack)-1]
            }
            sum := (prefixSum[j+1] - prefixSum[left+1] + mod) % mod
            maxProduct = max(maxProduct, sum*nums[j])
        }
        stack = append(stack, i)
    }

    return maxProduct % mod
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}