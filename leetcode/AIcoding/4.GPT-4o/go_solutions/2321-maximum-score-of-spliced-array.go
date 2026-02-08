func maximumScore(nums1 []int, nums2 []int) int {
    n := len(nums1)
    total1, total2 := 0, 0
    for _, num := range nums1 {
        total1 += num
    }
    for _, num := range nums2 {
        total2 += num
    }

    maxScore := total1 + total2

    for i := 0; i < n; i++ {
        score1 := total1 - nums1[i] + nums2[i]
        score2 := total2 - nums2[i] + nums1[i]
        maxScore = max(maxScore, score1, score2)
    }

    return maxScore
}

func max(a ...int) int {
    m := a[0]
    for _, v := range a {
        if v > m {
            m = v
        }
    }
    return m
}