func findAndReplacePattern(words []string, pattern string) []string {
    result := []string{}
    for _, word := range words {
        if match(word, pattern) {
            result = append(result, word)
        }
    }
    return result
}

func match(word, pattern string) bool {
    wToP := make(map[byte]byte)
    pToW := make(map[byte]byte)

    for i := 0; i < len(word); i++ {
        wChar := word[i]
        pChar := pattern[i]

        if wToP[wChar] == 0 && pToW[pChar] == 0 {
            wToP[wChar] = pChar
            pToW[pChar] = wChar
        } else if wToP[wChar] != pChar || pToW[pChar] != wChar {
            return false
        }
    }
    return true
}