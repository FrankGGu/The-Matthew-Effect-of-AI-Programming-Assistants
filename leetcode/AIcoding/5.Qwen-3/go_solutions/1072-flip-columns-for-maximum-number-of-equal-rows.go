package main

func maxEqualRowsAfterFlips(matrix [][]int) int {
    patternMap := make(map[string]int)
    for _, row := range matrix {
        pattern := ""
        for i, val := range row {
            if val == row[0] {
                pattern += "0"
            } else {
                pattern += "1"
            }
        }
        patternMap[pattern]++
    }
    max := 0
    for _, count := range patternMap {
        if count > max {
            max = count
        }
    }
    return max
}