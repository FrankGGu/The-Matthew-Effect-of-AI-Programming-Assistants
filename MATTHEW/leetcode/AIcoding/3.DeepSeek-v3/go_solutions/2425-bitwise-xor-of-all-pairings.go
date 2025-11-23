func xorAllNums(nums1 []int, nums2 []int) int {
    xor1, xor2 := 0, 0
    for _, num := range nums1 {
        xor1 ^= num
    }
    for _, num := range nums2 {
        xor2 ^= num
    }
    return (len(nums1) % 2 * xor2) ^ (len(nums2) % 2 * xor1)
}