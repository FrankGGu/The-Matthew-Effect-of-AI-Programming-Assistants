func intersection(nums1 []int, nums2 []int) []int {
    set1 := make(map[int]bool)
    for _, num := range nums1 {
        set1[num] = true
    }

    intersectSet := make(map[int]bool)
    for _, num := range nums2 {
        if set1[num] {
            intersectSet[num] = true
        }
    }

    result := make([]int, 0, len(intersectSet))
    for num := range intersectSet {
        result = append(result, num)
    }

    return result
}