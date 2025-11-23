func numberOfPairs(nums1 []int, nums2 []int, k int) int64 {
    freq := make(map[int]int)
    for _, num := range nums2 {
        freq[num*k]++
    }

    res := int64(0)
    for _, num := range nums1 {
        for d := 1; d*d <= num; d++ {
            if num%d == 0 {
                res += int64(freq[d])
                if d*d != num {
                    res += int64(freq[num/d])
                }
            }
        }
    }
    return res
}