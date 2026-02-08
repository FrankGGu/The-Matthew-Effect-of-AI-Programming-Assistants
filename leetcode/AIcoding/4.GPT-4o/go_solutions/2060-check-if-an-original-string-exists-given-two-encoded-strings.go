func decodeMessage(encoded1 string, encoded2 string) string {
    original := make([]byte, len(encoded1))
    mapping1 := make(map[byte]byte)
    mapping2 := make(map[byte]byte)

    for i := 0; i < len(encoded1); i++ {
        if encoded1[i] != ' ' {
            if _, exists := mapping1[encoded1[i]]; !exists {
                mapping1[encoded1[i]] = byte('a' + len(mapping1))
            }
            original[i] = mapping1[encoded1[i]]
        } else {
            original[i] = ' '
        }
    }

    for i := 0; i < len(encoded2); i++ {
        if encoded2[i] != ' ' {
            if _, exists := mapping2[encoded2[i]]; !exists {
                mapping2[encoded2[i]] = byte('a' + len(mapping2))
            }
            if mapping1[encoded1[i]] != mapping2[encoded2[i]] {
                return ""
            }
        }
    }

    return string(original)
}