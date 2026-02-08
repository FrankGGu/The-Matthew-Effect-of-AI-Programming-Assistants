func countAlmostEqualPairs(nums1 []int, nums2 []int) int64 {
    n := len(nums1)
    count := int64(0)
    freq := make(map[int]int)

    for i := 0; i < n; i++ {
        freq[nums1[i]-nums2[i]]++
    }

    for k, v := range freq {
        count += int64(v) * int64(v-1) / 2
        count += int64(v) * int64(freq[k+1])
        count += int64(v) * int64(freq[k-1])
    }

    return count
}