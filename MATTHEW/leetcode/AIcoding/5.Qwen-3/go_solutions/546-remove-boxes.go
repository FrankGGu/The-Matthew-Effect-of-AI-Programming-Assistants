package main

func removeBoxes(boxes []int) int {
    n := len(boxes)
    memo := make([][][]int, n)
    for i := range memo {
        memo[i] = make([][]int, n)
        for j := range memo[i] {
            memo[i][j] = make([]int, n+1)
        }
    }
    return dfs(boxes, 0, n-1, 0, memo)
}

func dfs(boxes []int, l, r, k int, memo [][][]int) int {
    if l > r {
        return 0
    }
    if memo[l][r][k] != 0 {
        return memo[l][r][k]
    }
    res := dfs(boxes, l+1, r, 0, memo) + 1
    for i := l + 1; i <= r; i++ {
        if boxes[i] == boxes[l] {
            temp := dfs(boxes, l+1, i-1, 0, memo) + dfs(boxes, i, r, k+1, memo)
            if temp > res {
                res = temp
            }
        }
    }
    memo[l][r][k] = res
    return res
}