func maximumXorProduct(nums []int) int {
    maxProduct := 0
    n := len(nums)
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            xor := nums[i] ^ nums[j]
            product := nums[i] * nums[j]
            if xor > maxProduct {
                maxProduct = xor
            }
            if product > maxProduct {
                maxProduct = product
            }
        }
    }
    return maxProduct
}