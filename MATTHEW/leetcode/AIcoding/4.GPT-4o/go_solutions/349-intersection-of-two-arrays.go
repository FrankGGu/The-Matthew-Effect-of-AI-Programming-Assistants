func intersection(nums1 []int, nums2 []int) []int {
    set := make(map[int]struct{})
    result := []int{}

    for _, num := range nums1 {
        set[num] = struct{}{}
    }

    for _, num := range nums2 {
        if _, exists := set[num]; exists {
            result = append(result, num)
            delete(set, num)
        }
    }

    return result
}