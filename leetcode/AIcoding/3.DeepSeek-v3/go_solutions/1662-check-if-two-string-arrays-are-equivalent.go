func arrayStringsAreEqual(word1 []string, word2 []string) bool {
    var s1, s2 strings.Builder
    for _, w := range word1 {
        s1.WriteString(w)
    }
    for _, w := range word2 {
        s2.WriteString(w)
    }
    return s1.String() == s2.String()
}