package main

func stableBinaryArrays(n int) [][]int {
    result := [][]int{}
    path := make([]int, n)

    var backtrack func(int, int)
    backtrack = func(pos int, prev int) {
        if pos == n {
            copyPath := make([]int, n)
            copy(copyPath, path)
            result = append(result, copyPath)
            return
        }

        for i := 0; i <= 1; i++ {
            if i == prev {
                continue
            }
            path[pos] = i
            backtrack(pos+1, i)
        }
    }

    backtrack(0, -1)
    return result
}