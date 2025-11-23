package main

func highestRankedKItems(board [][]int, priceLow int, priceHigh int) [][]int {
    var result [][]int
    var queue [][3]int
    rows, cols := len(board), len(board[0])

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if board[i][j] >= priceLow && board[i][j] <= priceHigh {
                queue = append(queue, [3]int{i, j, 0})
            }
        }
    }

    sort.Slice(queue, func(i, j int) bool {
        a, b := queue[i], queue[j]
        if a[2] != b[2] {
            return a[2] < b[2]
        }
        if a[0] != b[0] {
            return a[0] < b[0]
        }
        return a[1] < b[1]
    })

    for _, item := range queue {
        result = append(result, []int{item[0], item[1]})
    }

    return result
}