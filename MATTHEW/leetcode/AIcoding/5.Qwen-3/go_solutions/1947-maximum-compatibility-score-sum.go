package main

func maxScore(nums1 []int, nums2 []int) int {
    n := len(nums1)
    pairs := make([][2]int, n)
    for i := 0; i < n; i++ {
        pairs[i] = [2]int{nums1[i], nums2[i]}
    }

    sort.Slice(pairs, func(i, j int) bool {
        return pairs[i][0] < pairs[j][0]
    })

    sort.Ints(nums2)

    score := 0
    for i := 0; i < n; i++ {
        score += pairs[i][0] * nums2[i]
    }

    return score
}