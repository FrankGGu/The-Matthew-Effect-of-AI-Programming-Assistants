package main

func findLongestWord(s string, d []string) string {
    sort.Slice(d, func(i, j int) bool {
        if len(d[i]) != len(d[j]) {
            return len(d[i]) > len(d[j])
        }
        return d[i] < d[j]
    })

    for _, word := range d {
        if isSubsequence(word, s) {
            return word
        }
    }
    return ""
}

func isSubsequence(word string, s string) bool {
    i := 0
    for i < len(word) && len(s) > 0 {
        if word[i] == s[0] {
            i++
        }
        s = s[1:]
    }
    return i == len(word)
}