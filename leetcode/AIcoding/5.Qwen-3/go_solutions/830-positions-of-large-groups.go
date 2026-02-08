package main

func largeGroupPositions(s string) [][]int {
    result := [][]int{}
    n := len(s)
    i := 0
    for i < n {
        j := i
        for j < n && s[j] == s[i] {
            j++
        }
        if j-i >= 3 {
            result = append(result, []int{i, j - 1})
        }
        i = j
    }
    return result
}