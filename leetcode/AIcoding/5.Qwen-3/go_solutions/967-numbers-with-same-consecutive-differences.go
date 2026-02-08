package main

func numsSameConsecDiff(n int, k int) []int {
    result := []int{}
    for i := 1; i <= 9; i++ {
        dfs(n-1, k, i, &result)
    }
    return result
}

func dfs(remaining int, k int, current int, result *[]int) {
    if remaining == 0 {
        *result = append(*result, current)
        return
    }
    lastDigit := current % 10
    for nextDigit := 0; nextDigit <= 9; nextDigit++ {
        if abs(lastDigit-nextDigit) == k {
            dfs(remaining-1, k, current*10+nextDigit, result)
        }
    }
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}