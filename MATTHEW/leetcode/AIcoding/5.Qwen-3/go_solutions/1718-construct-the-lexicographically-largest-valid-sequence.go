package main

func numberSequence(n int) []int {
    result := make([]int, 0)
    used := make([]bool, n+1)

    var backtrack func(current []int) bool
    backtrack = func(current []int) bool {
        if len(current) == n {
            result = append(result, current...)
            return true
        }

        for i := n; i >= 1; i-- {
            if !used[i] {
                if len(current) == 0 || i%current[len(current)-1] == 0 || current[len(current)-1]%i == 0 {
                    used[i] = true
                    current = append(current, i)
                    if backtrack(current) {
                        return true
                    }
                    current = current[:len(current)-1]
                    used[i] = false
                }
            }
        }

        return false
    }

    backtrack([]int{})
    return result
}