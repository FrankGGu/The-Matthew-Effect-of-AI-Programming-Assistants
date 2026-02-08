func largestMerge(word1 string, word2 string) string {
    result := ""
    i, j := 0, 0
    n1, n2 := len(word1), len(word2)

    for i < n1 || j < n2 {
        if i < n1 && (j >= n2 || word1[i:] > word2[j:]) {
            result += string(word1[i])
            i++
        } else {
            result += string(word2[j])
            j++
        }
    }

    return result
}