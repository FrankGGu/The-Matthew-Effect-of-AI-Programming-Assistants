func countPairs(nums1 []int, nums2 []int, diff int) int64 {
    n := len(nums1)
    pairs := make([][2]int, n)
    for i := 0; i < n; i++ {
        pairs[i] = [2]int{nums1[i], nums2[i]}
    }

    sort.Slice(pairs, func(i, j int) bool {
        return pairs[i][0]-pairs[i][1] < pairs[j][0]-pairs[j][1]
    })

    count := int64(0)
    j := 0
    for i := 0; i < n; i++ {
        for j < n && pairs[j][0]-pairs[j][1] - (pairs[i][0]-pairs[i][1]) <= diff {
            j++
        }
        count += int64(j - i - 1)
    }

    return count
}