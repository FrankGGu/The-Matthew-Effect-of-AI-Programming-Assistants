func totalCharactersAfterTransformations(s string, transformations [][]string) int {
    charMap := make(map[byte]byte)
    for i := 0; i < 26; i++ {
        charMap[byte('a'+i)] = byte('a' + i)
    }

    for _, t := range transformations {
        oldChar := t[0][0]
        newChar := t[1][0]
        for k, v := range charMap {
            if v == oldChar {
                charMap[k] = newChar
            }
        }
    }

    transformed := make([]byte, len(s))
    for i := 0; i < len(s); i++ {
        transformed[i] = charMap[s[i]]
    }

    return len(string(transformed))
}