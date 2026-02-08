func intersect(nums1 []int, nums2 []int) []int {
    count := make(map[int]int)
    result := []int{}

    for _, num := range nums1 {
        count[num]++
    }

    for _, num := range nums2 {
        if count[num] > 0 {
            result = append(result, num)
            count[num]--
        }
    }

    return result
}