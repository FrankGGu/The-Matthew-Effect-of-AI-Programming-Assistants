package main

func pushDominoes(dominoes string) string {
    n := len(dominoes)
    left := make([]int, n)
    right := make([]int, n)
    for i := 0; i < n; i++ {
        if dominoes[i] == 'R' {
            j := i + 1
            for j < n && dominoes[j] == '.' {
                right[j]++
                j++
            }
        } else if dominoes[i] == 'L' {
            j := i - 1
            for j >= 0 && dominoes[j] == '.' {
                left[j]++
                j--
            }
        }
    }
    res := []rune(dominoes)
    for i := 0; i < n; i++ {
        if res[i] == '.' {
            if right[i] > left[i] {
                res[i] = 'R'
            } else if left[i] > right[i] {
                res[i] = 'L'
            }
        }
    }
    return string(res)
}