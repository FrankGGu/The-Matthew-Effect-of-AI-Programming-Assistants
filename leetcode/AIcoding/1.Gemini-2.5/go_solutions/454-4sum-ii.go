func fourSumCount(nums1 []int, nums2 []int, nums3 []int, nums4 []int) int {
    sum12 := make(map[int]int)

    for _, n1 := range nums1 {
        for _, n2 := range nums2 {
            sum12[n1+n2]++
        }
    }

    count := 0
    for _, n3 := range nums3 {
        for _, n4 := range nums4 {
            target := -(n3 + n4)
            if freq, ok := sum12[target]; ok {
                count += freq
            }
        }
    }

    return count
}