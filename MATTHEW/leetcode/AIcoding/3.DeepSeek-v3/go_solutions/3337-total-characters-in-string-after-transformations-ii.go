func totalCharactersAfterTransformations(s string, transformations [][]string) int {
    charMap := make(map[byte]byte)
    for i := byte('a'); i <= 'z'; i++ {
        charMap[i] = i
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

    count := 0
    for i := 0; i < len(s); i++ {
        count++
    }
    return count
}