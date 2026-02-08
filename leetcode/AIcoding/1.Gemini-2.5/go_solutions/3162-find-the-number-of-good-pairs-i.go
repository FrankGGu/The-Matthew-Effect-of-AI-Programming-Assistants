func numberOfGoodPairs(nums1 []int, nums2 []int, k int) int {
    count := 0
    for i := 0; i < len(nums1); i++ {
        for j := 0; j < len(nums2); j++ {
            divisor := nums2[j] * k
            if nums1[i]%divisor == 0 {
                count++
            }
        }
    }
    return count
}