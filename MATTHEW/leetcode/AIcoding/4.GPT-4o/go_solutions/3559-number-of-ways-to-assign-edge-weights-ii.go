package main

import "fmt"

func countWays(n int, edges [][]int) int {
    mod := 1_000_000_007
    degree := make([]int, n)
    for _, edge := range edges {
        degree[edge[0]]++
        degree[edge[1]]++
    }

    ways := 1
    for _, deg := range degree {
        ways = (ways * (deg + 1)) % mod
    }
    return ways
}

func main() {
    n := 3
    edges := [][]int{{0, 1}, {1, 2}, {0, 2}}
    fmt.Println(countWays(n, edges))
}