package main

import "fmt"

func maxEqualRowsAfterFlips(matrix [][]int) int {
    count := make(map[string]int)
    for _, row := range matrix {
        pattern := ""
        for j, val := range row {
            if j == 0 || val != row[0] {
                pattern += fmt.Sprintf("%d", val^row[0])
            } else {
                pattern += fmt.Sprintf("%d", val)
            }
        }
        count[pattern]++
    }

    maxCount := 0
    for _, val := range count {
        if val > maxCount {
            maxCount = val
        }
    }

    return maxCount
}

func main() {
    // Example usage
    matrix := [][]int{{0, 1}, {1, 0}, {1, 0}}
    fmt.Println(maxEqualRowsAfterFlips(matrix)) // Output: 2
}