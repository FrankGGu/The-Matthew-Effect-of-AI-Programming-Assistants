func canConvert(str1 string, str2 string) bool {
    if str1 == str2 {
        return true
    }

    conversionMap := make(map[byte]byte)
    uniqueCharsInStr2 := make(map[byte]bool)

    for i := 0; i < len(str1); i++ {
        char1 := str1[i]
        char2 := str2[i]

        if val, exists := conversionMap[char1]; exists {
            if val != char2 {
                return false
            }
        } else {
            conversionMap[char1] = char2
            uniqueCharsInStr2[char2] = true
        }
    }

    return len(uniqueCharsInStr2) < 26
}