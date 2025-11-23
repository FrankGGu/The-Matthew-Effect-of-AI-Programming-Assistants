package main

func vowelStrings(words []string, queries [][]int) []int {
    n := len(words)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        if isVowel(rune(words[i][0])) && isVowel(rune(words[i][len(words[i])-1])) {
            prefix[i+1] = prefix[i] + 1
        } else {
            prefix[i+1] = prefix[i]
        }
    }
    res := make([]int, len(queries))
    for i, q := range queries {
        res[i] = prefix[q[1]+1] - prefix[q[0]]
    }
    return res
}

func isVowel(c rune) bool {
    return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u'
}