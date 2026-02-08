func getXORSum(nums1 []int, nums2 []int) int {
    xorSum1 := 0
    for _, num := range nums1 {
        xorSum1 ^= num
    }

    xorSum2 := 0
    for _, num := range nums2 {
        xorSum2 ^= num
    }

    return xorSum1 & xorSum2
}