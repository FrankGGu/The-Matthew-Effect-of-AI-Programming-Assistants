func smallestTrimmedNumbers(nums []string, queries [][]int) []int {
    res := make([]int, len(queries))
    for i, q := range queries {
        k, trim := q[0], q[1]
        trimmed := make([]string, len(nums))
        for j, num := range nums {
            if trim >= len(num) {
                trimmed[j] = num
            } else {
                trimmed[j] = num[len(num)-trim:]
            }
        }
        indices := make([]int, len(nums))
        for j := range indices {
            indices[j] = j
        }
        sort.Slice(indices, func(a, b int) bool {
            if trimmed[indices[a]] == trimmed[indices[b]] {
                return indices[a] < indices[b]
            }
            return trimmed[indices[a]] < trimmed[indices[b]]
        })
        res[i] = indices[k-1]
    }
    return res
}