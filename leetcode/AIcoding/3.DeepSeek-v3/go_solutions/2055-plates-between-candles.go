func platesBetweenCandles(s string, queries [][]int) []int {
    n := len(s)
    left := make([]int, n)
    right := make([]int, n)
    prefix := make([]int, n+1)

    last := -1
    for i := 0; i < n; i++ {
        if s[i] == '|' {
            last = i
        }
        left[i] = last
    }

    last = -1
    for i := n-1; i >= 0; i-- {
        if s[i] == '|' {
            last = i
        }
        right[i] = last
    }

    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i]
        if s[i] == '*' {
            prefix[i+1]++
        }
    }

    res := make([]int, len(queries))
    for i, q := range queries {
        l, r := q[0], q[1]
        x := right[l]
        y := left[r]
        if x == -1 || y == -1 || x >= y {
            res[i] = 0
        } else {
            res[i] = prefix[y+1] - prefix[x+1]
        }
    }
    return res
}