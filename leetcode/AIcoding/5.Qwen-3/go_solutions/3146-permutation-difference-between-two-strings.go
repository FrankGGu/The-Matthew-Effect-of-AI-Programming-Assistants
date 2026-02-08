package main

func permutationDifference(s string, t string) int {
    pos := make([]int, 26)
    for i, c := range s {
        pos[c-'a'] = i
    }
    res := 0
    for i, c := range t {
        res += abs(i - pos[c-'a'])
    }
    return res
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}