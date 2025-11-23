package main

func maxRemovableOccurrences(s string, p string, removable []int) int {
    m, n := len(s), len(p)
    i, j := 0, 0
    removed := make(map[int]bool)
    for _, idx := range removable {
        removed[idx] = true
    }
    for i < m && j < n {
        if !removed[i] && s[i] == p[j] {
            j++
        }
        i++
    }
    return j
}