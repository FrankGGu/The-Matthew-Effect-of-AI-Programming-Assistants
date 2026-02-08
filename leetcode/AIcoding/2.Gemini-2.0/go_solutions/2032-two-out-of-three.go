func twoOutOfThree(nums1 []int, nums2 []int, nums3 []int) []int {
    set1 := make(map[int]bool)
    set2 := make(map[int]bool)
    set3 := make(map[int]bool)

    for _, num := range nums1 {
        set1[num] = true
    }
    for _, num := range nums2 {
        set2[num] = true
    }
    for _, num := range nums3 {
        set3[num] = true
    }

    result := []int{}
    count := make(map[int]int)

    for num := range set1 {
        count[num]++
    }
    for num := range set2 {
        count[num]++
    }
    for num := range set3 {
        count[num]++
    }

    for num, c := range count {
        if c >= 2 {
            result = append(result, num)
        }
    }

    return result
}