package main

func findChampion(n int, edges [][]int) int {
    inDegree := make([]int, n)
    for _, edge := range edges {
        inDegree[edge[1]]++
    }

    var candidates []int
    for i := 0; i < n; i++ {
        if inDegree[i] == 0 {
            candidates = append(candidates, i)
        }
    }

    if len(candidates) != 1 {
        return -1
    }

    return candidates[0]
}