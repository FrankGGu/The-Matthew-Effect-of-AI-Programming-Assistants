package main

func isPossibleToMakeZero(arr []int, queries [][]int) []bool {
    n := len(arr)
    diff := make([]int, n+1)

    for _, q := range queries {
        l, r, val := q[0], q[1], q[2]
        diff[l] += val
        if r+1 < n {
            diff[r+1] -= val
        }
    }

    current := 0
    result := make([]bool, n)

    for i := 0; i < n; i++ {
        current += diff[i]
        arr[i] -= current
        result[i] = arr[i] == 0
    }

    return result
}