func largestMerge(word1 string, word2 string) string {
    merge := []byte{}
    i, j := 0, 0
    for i < len(word1) && j < len(word2) {
        if word1[i:] > word2[j:] {
            merge = append(merge, word1[i])
            i++
        } else {
            merge = append(merge, word2[j])
            j++
        }
    }
    merge = append(merge, word1[i:]...)
    merge = append(merge, word2[j:]...)
    return string(merge)
}