func minimumDistance(word string) int {
    n := len(word)
    if n <= 2 {
        return 0
    }

    memo := make([][26][26]int, n)
    for i := range memo {
        for j := range memo[i] {
            for k := range memo[i][j] {
                memo[i][j][k] = -1
            }
        }
    }

    var dfs func(int, byte, byte) int
    dfs = func(pos int, a, b byte) int {
        if pos == n {
            return 0
        }
        if memo[pos][a-'A'][b-'A'] != -1 {
            return memo[pos][a-'A'][b-'A']
        }
        c := word[pos]
        costA := dist(a, c)
        costB := dist(b, c)
        res := min(costA + dfs(pos+1, c, b), costB + dfs(pos+1, a, c))
        memo[pos][a-'A'][b-'A'] = res
        return res
    }

    res := math.MaxInt32
    for i := 0; i < 26; i++ {
        for j := 0; j < 26; j++ {
            a := byte('A' + i)
            b := byte('A' + j)
            res = min(res, dfs(0, a, b))
        }
    }
    return res
}

func dist(a, b byte) int {
    if a == 0 {
        return 0
    }
    x1, y1 := int(a-'A')/6, int(a-'A')%6
    x2, y2 := int(b-'A')/6, int(b-'A')%6
    return abs(x1-x2) + abs(y1-y2)
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}