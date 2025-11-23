func maxProduct(words []string) int {
    masks := make([]int, len(words))
    for i, word := range words {
        for _, c := range word {
            masks[i] |= 1 << (c - 'a')
        }
    }
    max := 0
    for i := 0; i < len(words); i++ {
        for j := i + 1; j < len(words); j++ {
            if masks[i]&masks[j] == 0 && len(words[i])*len(words[j]) > max {
                max = len(words[i]) * len(words[j])
            }
        }
    }
    return max
}