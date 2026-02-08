import "sort"

func maxScore(nums1 []int, nums2 []int, k int) int64 {
    n := len(nums1)
    pairs := make([][2]int, n)
    for i := 0; i < n; i++ {
        pairs[i] = [2]int{nums1[i], nums2[i]}
    }
    sort.Slice(pairs, func(i, j int) bool {
        return pairs[i][1] > pairs[j][1]
    })

    minHeap := []int{}
    sum := 0
    result := int64(0)

    for i := 0; i < k; i++ {
        sum += pairs[i][0]
        minHeap = append(minHeap, pairs[i][0])
    }
    result = int64(sum) * int64(pairs[k-1][1])

    for i := k; i < n; i++ {
        sum += pairs[i][0]
        minHeap = append(minHeap, pairs[i][0])
        sum -= minHeap[0]
        minHeap = minHeap[1:]
        result = max(result, int64(sum)*int64(pairs[i][1]))
    }

    return result
}

func max(a, b int64) int64 {
    if a > b {
        return a
    }
    return b
}