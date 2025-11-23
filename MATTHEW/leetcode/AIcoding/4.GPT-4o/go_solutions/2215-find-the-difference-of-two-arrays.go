func findDifference(nums1 []int, nums2 []int) [][]int {
    set1 := make(map[int]struct{})
    set2 := make(map[int]struct{})

    for _, num := range nums1 {
        set1[num] = struct{}{}
    }

    for _, num := range nums2 {
        set2[num] = struct{}{}
    }

    diff1 := []int{}
    diff2 := []int{}

    for num := range set1 {
        if _, exists := set2[num]; !exists {
            diff1 = append(diff1, num)
        }
    }

    for num := range set2 {
        if _, exists := set1[num]; !exists {
            diff2 = append(diff2, num)
        }
    }

    return [][]int{diff1, diff2}
}