func minimumTotalCost(nums1 []int, nums2 []int) int64 {
    n := len(nums1)
    freq := make(map[int]int)
    maxFreq := 0
    maxFreqVal := 0
    total := 0
    res := int64(0)

    for i := 0; i < n; i++ {
        if nums1[i] == nums2[i] {
            freq[nums1[i]]++
            if freq[nums1[i]] > maxFreq {
                maxFreq = freq[nums1[i]]
                maxFreqVal = nums1[i]
            }
            total++
            res += int64(i)
        }
    }

    for i := 0; i < n; i++ {
        if maxFreq > total/2 && nums1[i] != nums2[i] && nums1[i] != maxFreqVal && nums2[i] != maxFreqVal {
            total++
            res += int64(i)
        }
    }

    if maxFreq > total/2 {
        return -1
    }
    return res
}