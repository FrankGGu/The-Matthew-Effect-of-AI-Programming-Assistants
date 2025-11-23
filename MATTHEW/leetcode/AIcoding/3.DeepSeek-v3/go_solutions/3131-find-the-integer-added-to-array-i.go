func addedInteger(nums1 []int, nums2 []int) int {
    min1 := nums1[0]
    min2 := nums2[0]
    for _, num := range nums1 {
        if num < min1 {
            min1 = num
        }
    }
    for _, num := range nums2 {
        if num < min2 {
            min2 = num
        }
    }
    return min2 - min1
}