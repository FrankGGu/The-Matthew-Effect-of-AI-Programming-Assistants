func vowelStrings(words []string, queries [][]int) []int {
    n := len(words)
    prefix := make([]int, n+1)
    vowels := map[byte]bool{'a': true, 'e': true, 'i': true, 'o': true, 'u': true}

    for i := 0; i < n; i++ {
        word := words[i]
        first, last := word[0], word[len(word)-1]
        if vowels[first] && vowels[last] {
            prefix[i+1] = prefix[i] + 1
        } else {
            prefix[i+1] = prefix[i]
        }
    }

    res := make([]int, len(queries))
    for i, q := range queries {
        l, r := q[0], q[1]
        res[i] = prefix[r+1] - prefix[l]
    }
    return res
}