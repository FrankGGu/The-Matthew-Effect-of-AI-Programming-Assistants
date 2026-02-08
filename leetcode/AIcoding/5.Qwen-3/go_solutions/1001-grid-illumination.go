package main

func gridIllumination(n int, queries []int, hits [][]int) []int {
    type point struct {
        x, y int
    }
    lights := map[point]bool{}
    lightCount := map[point]int{}
    row := map[int]int{}
    col := map[int]int{}
    diag1 := map[int]int{}
    diag2 := map[int]int{}
    visited := map[point]bool{}

    for _, hit := range hits {
        x, y := hit[0], hit[1]
        p := point{x, y}
        if !visited[p] {
            visited[p] = true
            if lights[p] {
                lights[p] = false
                row[x]--
                col[y]--
                diag1[x-y]--
                diag2[x+y]--
            }
        }
    }

    for _, query := range queries {
        x, y := query/1000, query%1000
        p := point{x, y}
        if !visited[p] {
            visited[p] = true
            if lights[p] {
                lights[p] = false
                row[x]--
                col[y]--
                diag1[x-y]--
                diag2[x+y]--
            }
        }
    }

    for _, q := range queries {
        x, y := q/1000, q%1000
        if row[x] > 0 || col[y] > 0 || diag1[x-y] > 0 || diag2[x+y] > 0 {
            lightCount[point{x, y}]++
        }
    }

    res := make([]int, len(queries))
    for i, q := range queries {
        x, y := q/1000, q%1000
        if row[x] > 0 || col[y] > 0 || diag1[x-y] > 0 || diag2[x+y] > 0 {
            res[i] = 1
        } else {
            res[i] = 0
        }
    }

    return res
}