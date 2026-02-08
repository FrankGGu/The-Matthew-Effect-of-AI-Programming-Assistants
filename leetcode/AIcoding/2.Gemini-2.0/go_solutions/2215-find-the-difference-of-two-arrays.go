func findDifference(nums1 []int, nums2 []int) [][]int {
    set1 := make(map[int]bool)
    set2 := make(map[int]bool)

    for _, num := range nums1 {
        set1[num] = true
    }
    for _, num := range nums2 {
        set2[num] = true
    }

    result1 := []int{}
    for num := range set1 {
        if !set2[num] {
            result1 = append(result1, num)
        }
    }

    result2 := []int{}
    for num := range set2 {
        if !set1[num] {
            result2 = append(result2, num)
        }
    }

    return [][]int{result1, result2}
}