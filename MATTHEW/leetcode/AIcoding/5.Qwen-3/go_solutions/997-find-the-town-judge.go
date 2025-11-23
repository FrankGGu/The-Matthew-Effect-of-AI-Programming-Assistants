package main

func findJudge(n int, trust [][]int) int {
    inDegree := make([]int, n+1)
    outDegree := make([]int, n+1)

    for _, t := range trust {
        outDegree[t[0]]++
        inDegree[t[1]]++
    }

    for i := 1; i <= n; i++ {
        if inDegree[i] == n-1 && outDegree[i] == 0 {
            return i
        }
    }

    return -1
}