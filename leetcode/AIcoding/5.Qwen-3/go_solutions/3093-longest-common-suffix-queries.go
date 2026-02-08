package main

func longestCommonSuffixQueries(s string, queries [][]int) []int {
    n := len(s)
    suffixTrie := make(map[rune]map[int]int)
    for i := 0; i < n; i++ {
        current := suffixTrie
        for j := i; j < n; j++ {
            c := rune(s[j])
            if _, ok := current[c]; !ok {
                current[c] = make(map[int]int)
            }
            current = current[c]
            current[j-i]++
        }
    }
    result := make([]int, len(queries))
    for i, q := range queries {
        l, r := q[0], q[1]
        current := suffixTrie
        maxLen := 0
        for j := l; j <= r; j++ {
            c := rune(s[j])
            if _, ok := current[c]; !ok {
                break
            }
            current = current[c]
            maxLen++
        }
        result[i] = maxLen
    }
    return result
}