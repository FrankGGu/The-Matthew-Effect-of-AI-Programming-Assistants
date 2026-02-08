func maxProduct(words []string) int {
    n := len(words)
    masks := make([]int, n)

    for i, word := range words {
        mask := 0
        for _, c := range word {
            mask |= 1 << (c - 'a')
        }
        masks[i] = mask
    }

    max := 0
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if masks[i] & masks[j] == 0 {
                product := len(words[i]) * len(words[j])
                if product > max {
                    max = product
                }
            }
        }
    }

    return max
}