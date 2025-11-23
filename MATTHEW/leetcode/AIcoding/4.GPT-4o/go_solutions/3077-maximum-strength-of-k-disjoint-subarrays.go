func maxStrength(nums []int, k int) int {
    n := len(nums)
    if k == 0 {
        return 0
    }

    // Function to calculate the maximum strength of k disjoint subarrays
    var dfs func(start, count int) int
    dfs = func(start, count int) int {
        if count == 0 {
            return 1
        }
        maxProduct := math.MinInt32
        currentProduct := 1
        for i := start; i <= n-k+count; i++ {
            currentProduct *= nums[i]
            if count > 1 {
                maxProduct = max(maxProduct, currentProduct*dfs(i+1, count-1))
            } else {
                maxProduct = max(maxProduct, currentProduct)
            }
            if currentProduct == 0 {
                currentProduct = 1
            }
        }
        return maxProduct
    }

    return dfs(0, k)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}