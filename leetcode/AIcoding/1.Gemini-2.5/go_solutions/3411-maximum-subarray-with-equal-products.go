func maxProduct(nums []int) int {
    if len(nums) == 0 {
        return 0
    }
    maxProd, minProd, res := nums[0], nums[0], nums[0]
    for i := 1; i < len(nums); i++ {
        if nums[i] < 0 {
            maxProd, minProd = minProd, maxProd
        }
        maxProd = max(nums[i], maxProd * nums[i])
        minProd = min(nums[i], minProd * nums[i])
        res = max(res, maxProd)
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}