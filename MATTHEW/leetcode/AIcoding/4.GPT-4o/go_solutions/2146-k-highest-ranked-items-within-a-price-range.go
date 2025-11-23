func highestRankedKItems(grid [][]int, pricing []int, k int) [][]int {
    m, n := len(grid), len(grid[0])
    var items [][]int

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] >= pricing[0] && grid[i][j] <= pricing[1] {
                items = append(items, []int{i, j, grid[i][j]})
            }
        }
    }

    sort.Slice(items, func(i, j int) bool {
        if items[i][2] == items[j][2] {
            if items[i][0] == items[j][0] {
                return items[i][1] < items[j][1]
            }
            return items[i][0] < items[j][0]
        }
        return items[i][2] < items[j][2]
    })

    if len(items) > k {
        items = items[:k]
    }

    result := make([][]int, len(items))
    for i := 0; i < len(items); i++ {
        result[i] = []int{items[i][0], items[i][1]}
    }

    return result
}