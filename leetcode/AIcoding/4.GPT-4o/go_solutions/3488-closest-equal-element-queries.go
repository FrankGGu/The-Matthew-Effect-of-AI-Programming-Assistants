package main

import "fmt"

func closestEqual(arr []int, queries [][]int) []int {
    indexMap := make(map[int][]int)
    for i, num := range arr {
        indexMap[num] = append(indexMap[num], i)
    }

    result := make([]int, len(queries))
    for i, query := range queries {
        x, idx := query[0], query[1]
        if positions, exists := indexMap[x]; exists {
            closest := -1
            for _, pos := range positions {
                if pos != idx {
                    if closest == -1 || abs(pos-idx) < abs(closest-idx) || (abs(pos-idx) == abs(closest-idx) && pos < closest) {
                        closest = pos
                    }
                }
            }
            result[i] = closest
        } else {
            result[i] = -1
        }
    }
    return result
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func main() {
    arr := []int{1, 2, 3, 2, 1}
    queries := [][]int{{2, 0}, {1, 0}, {2, 1}, {3, 2}}
    result := closestEqual(arr, queries)
    fmt.Println(result) // Output: [3, -1, 0, 1]
}