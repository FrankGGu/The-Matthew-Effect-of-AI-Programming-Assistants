import "sort"

func maxSubsequence(nums []int, k int) []int {
    indexedNums := make([][2]int, len(nums))
    for i, num := range nums {
        indexedNums[i] = [2]int{num, i}
    }

    sort.Slice(indexedNums, func(i, j int) bool {
        return indexedNums[i][0] > indexedNums[j][0]
    })

    topK := indexedNums[:k]
    sort.Slice(topK, func(i, j int) bool {
        return topK[i][1] < topK[j][1]
    })

    res := make([]int, k)
    for i, num := range topK {
        res[i] = num[0]
    }

    return res
}