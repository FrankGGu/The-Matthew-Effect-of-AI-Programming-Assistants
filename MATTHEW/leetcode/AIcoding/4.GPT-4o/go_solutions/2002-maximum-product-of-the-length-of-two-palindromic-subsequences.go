func maxProduct(words []string) int {
    n := len(words)
    masks := make([]int, n)

    for i, word := range words {
        for _, char := range word {
            masks[i] |= 1 << (char - 'a')
        }
    }

    maxProduct := 0
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if masks[i]&masks[j] == 0 {
                product := len(words[i]) * len(words[j])
                if product > maxProduct {
                    maxProduct = product
                }
            }
        }
    }

    return maxProduct
}