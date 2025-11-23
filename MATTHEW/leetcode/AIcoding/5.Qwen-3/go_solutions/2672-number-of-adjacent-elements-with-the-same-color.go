package main

func numberOfAdjacentElementsWithTheSameColor(colors []int, queries []int) []int {
    n := len(colors)
    res := make([]int, len(queries))
    for i, q := range queries {
        if q >= n-1 {
            res[i] = 0
            continue
        }
        if colors[q] == colors[q+1] {
            res[i] = 1
        } else {
            res[i] = 0
        }
    }
    return res
}