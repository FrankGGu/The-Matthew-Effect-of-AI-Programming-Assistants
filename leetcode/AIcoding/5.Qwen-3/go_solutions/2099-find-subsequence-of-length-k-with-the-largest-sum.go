package main

func maxSubsequenceScore(nums []int, k int) []int {
    n := len(nums)
    type pair struct {
        val int
        idx int
    }
    pairs := make([]pair, n)
    for i := 0; i < n; i++ {
        pairs[i] = pair{nums[i], i}
    }
    sort.Slice(pairs, func(i, j int) bool {
        return pairs[i].val > pairs[j].val
    })
    topK := make([]pair, k)
    for i := 0; i < k; i++ {
        topK[i] = pairs[i]
    }
    sort.Slice(topK, func(i, j int) bool {
        return topK[i].idx < topK[j].idx
    })
    result := make([]int, k)
    for i := 0; i < k; i++ {
        result[i] = topK[i].val
    }
    return result
}