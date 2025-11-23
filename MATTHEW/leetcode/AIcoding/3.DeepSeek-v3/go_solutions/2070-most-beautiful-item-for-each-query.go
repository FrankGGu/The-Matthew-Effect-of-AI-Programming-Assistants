import "sort"

func maximumBeauty(items [][]int, queries []int) []int {
    sort.Slice(items, func(i, j int) bool {
        return items[i][0] < items[j][0]
    })

    maxBeauty := make([]int, len(items))
    maxBeauty[0] = items[0][1]
    for i := 1; i < len(items); i++ {
        maxBeauty[i] = max(maxBeauty[i-1], items[i][1])
    }

    res := make([]int, len(queries))
    for i, q := range queries {
        idx := sort.Search(len(items), func(j int) bool {
            return items[j][0] > q
        })
        if idx == 0 {
            res[i] = 0
        } else {
            res[i] = maxBeauty[idx-1]
        }
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}