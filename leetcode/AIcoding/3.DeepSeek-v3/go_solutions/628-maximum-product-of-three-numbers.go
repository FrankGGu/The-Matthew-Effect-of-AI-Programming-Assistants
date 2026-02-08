func maximumProduct(nums []int) int {
    sort.Ints(nums)
    n := len(nums)
    product1 := nums[n-1] * nums[n-2] * nums[n-3]
    product2 := nums[0] * nums[1] * nums[n-1]
    if product1 > product2 {
        return product1
    }
    return product2
}