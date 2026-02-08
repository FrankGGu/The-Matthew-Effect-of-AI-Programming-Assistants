package main

func arrayRankTransform(matrix [][]int) [][]int {
    if len(matrix) == 0 || len(matrix[0]) == 0 {
        return [][]int{}
    }

    rankMap := make(map[int]int)
    uniqueValues := make([]int, 0)

    for _, row := range matrix {
        for _, val := range row {
            if _, exists := rankMap[val]; !exists {
                uniqueValues = append(uniqueValues, val)
            }
        }
    }

    sort.Ints(uniqueValues)

    for i, val := range uniqueValues {
        rankMap[val] = i + 1
    }

    result := make([][]int, len(matrix))
    for i, row := range matrix {
        result[i] = make([]int, len(row))
        for j, val := range row {
            result[i][j] = rankMap[val]
        }
    }

    return result
}