func getCommon(nums1 []int, nums2 []int) int {
    set := make(map[int]bool)
    for _, num := range nums1 {
        set[num] = true
    }
    for _, num := range nums2 {
        if set[num] {
            return num
        }
    }
    return -1
}