package main

func maxSubsequenceSum(nums []int, k int) int {
    type pair struct {
        val int
        idx int
    }
    n := len(nums)
    pairs := make([]pair, n)
    for i := 0; i < n; i++ {
        pairs[i] = pair{nums[i], i}
    }
    sort.Slice(pairs, func(i, j int) bool {
        if pairs[i].val != pairs[j].val {
            return pairs[i].val > pairs[j].val
        }
        return pairs[i].idx < pairs[j].idx
    })
    res := 0
    indices := make([]int, 0, k)
    for i := 0; i < k && i < n; i++ {
        res += pairs[i].val
        indices = append(indices, pairs[i].idx)
    }
    sort.Ints(indices)
    result := 0
    for _, idx := range indices {
        result += nums[idx]
    }
    return result
}