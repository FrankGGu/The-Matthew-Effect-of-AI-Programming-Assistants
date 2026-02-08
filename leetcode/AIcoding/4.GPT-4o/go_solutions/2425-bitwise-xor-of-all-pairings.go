func xorAllNums(nums1 []int, nums2 []int) int {
    len1, len2 := len(nums1), len(nums2)
    if len1%2 == 0 && len2%2 == 0 {
        return 0
    }
    if len1%2 == 1 && len2%2 == 1 {
        return xor(nums1) ^ xor(nums2)
    }
    if len1%2 == 1 {
        return xor(nums1)
    }
    return xor(nums2)
}

func xor(nums []int) int {
    result := 0
    for _, num := range nums {
        result ^= num
    }
    return result
}