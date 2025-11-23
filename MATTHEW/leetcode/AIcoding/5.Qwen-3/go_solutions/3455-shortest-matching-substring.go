package main

func shortestSubstrings(s string, queries []int) []string {
    n := len(s)
    result := make([]string, len(queries))

    for i, k := range queries {
        minLen := n + 1
        var ans string

        for l := 0; l < n; l++ {
            freq := make(map[byte]int)
            unique := 0
            for r := l; r < n; r++ {
                if freq[s[r]] == 0 {
                    unique++
                }
                freq[s[r]]++

                if unique == k {
                    length := r - l + 1
                    if length < minLen {
                        minLen = length
                        ans = s[l : r+1]
                    }
                    break
                }
            }
        }

        result[i] = ans
    }

    return result
}