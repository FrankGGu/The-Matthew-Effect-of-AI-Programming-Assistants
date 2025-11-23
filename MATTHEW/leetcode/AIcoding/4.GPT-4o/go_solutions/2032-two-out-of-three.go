func twoOutOfThree(nums1 []int, nums2 []int, nums3 []int) []int {
    freq := make(map[int]int)

    for _, num := range nums1 {
        freq[num] = 1
    }
    for _, num := range nums2 {
        if _, exists := freq[num]; exists {
            freq[num] = 2
        } else {
            freq[num] = 1
        }
    }
    for _, num := range nums3 {
        if _, exists := freq[num]; exists {
            freq[num] = 3
        } else {
            freq[num] = 1
        }
    }

    result := []int{}
    for num, count := range freq {
        if count >= 2 {
            result = append(result, num)
        }
    }

    return result
}