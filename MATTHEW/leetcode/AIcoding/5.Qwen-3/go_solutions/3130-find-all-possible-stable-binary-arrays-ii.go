package main

func stableBinaryArrays(n int, k int) [][]int {
    result := [][]int{}
    path := make([]int, n)

    var backtrack func(int, int)
    backtrack = func(pos int, ones int) {
        if pos == n {
            result = append(result, append([]int(nil), path...))
            return
        }

        if ones < k {
            path[pos] = 1
            backtrack(pos+1, ones+1)
            path[pos] = 0
        }

        if pos == 0 || path[pos-1] == 0 {
            path[pos] = 0
            backtrack(pos+1, ones)
            path[pos] = 0
        }
    }

    backtrack(0, 0)
    return result
}