func findIntersectionValues(nums1 []int, nums2 []int) []int {
    set1 := make(map[int]bool)
    set2 := make(map[int]bool)

    for _, num := range nums1 {
        set1[num] = true
    }

    for _, num := range nums2 {
        set2[num] = true
    }

    count1 := 0
    for _, num := range nums1 {
        if set2[num] {
            count1++
        }
    }

    count2 := 0
    for _, num := range nums2 {
        if set1[num] {
            count2++
        }
    }

    return []int{count1, count2}
}