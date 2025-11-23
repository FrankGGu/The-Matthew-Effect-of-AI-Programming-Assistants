func countAlmostEqualPairs(nums1 []int, nums2 []int) int {
    count := 0
    n := len(nums1)
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if i != j && nums1[i] == nums2[j] {
                count++
            }
        }
    }
    return count
}