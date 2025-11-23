package main

func platesBetweenCandles(prerequisites string, queries [][]int) []int {
    n := len(prerequisites)
    left := make([]int, n)
    right := make([]int, n)
    prefix := make([]int, n)

    for i := 0; i < n; i++ {
        if prerequisites[i] == '*' {
            prefix[i] = 0
        } else {
            prefix[i] = 1
        }
        if i > 0 {
            prefix[i] += prefix[i-1]
        }
    }

    for i := 0; i < n; i++ {
        if prerequisites[i] == '*' {
            left[i] = -1
        } else {
            left[i] = i
        }
        if i > 0 && left[i] == -1 {
            left[i] = left[i-1]
        }
    }

    for i := n - 1; i >= 0; i-- {
        if prerequisites[i] == '*' {
            right[i] = -1
        } else {
            right[i] = i
        }
        if i < n-1 && right[i] == -1 {
            right[i] = right[i+1]
        }
    }

    res := make([]int, len(queries))
    for i, q := range queries {
        l, r := q[0], q[1]
        first := right[l]
        last := left[r]
        if first == -1 || last == -1 || first >= last {
            res[i] = 0
        } else {
            res[i] = prefix[last] - prefix[first]
        }
    }

    return res
}