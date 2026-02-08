func intersection(nums1 []int, nums2 []int) []int {
    set1 := make(map[int]bool)
    for _, num := range nums1 {
        set1[num] = true
    }

    intersectionSet := make(map[int]bool)
    for _, num := range nums2 {
        if set1[num] {
            intersectionSet[num] = true
        }
    }

    result := []int{}
    for num := range intersectionSet {
        result = append(result, num)
    }

    return result
}