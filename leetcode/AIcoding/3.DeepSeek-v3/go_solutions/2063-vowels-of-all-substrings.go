func countVowels(word string) int64 {
    vowels := map[byte]bool{'a': true, 'e': true, 'i': true, 'o': true, 'u': true}
    var res int64
    n := int64(len(word))
    for i := int64(0); i < n; i++ {
        if vowels[word[i]] {
            res += (i + 1) * (n - i)
        }
    }
    return res
}