package main

func maxProduct(words []string) int {
    n := len(words)
    masks := make([]int, n)
    for i := 0; i < n; i++ {
        mask := 0
        for _, c := range words[i] {
            mask |= 1 << (c - 'a')
        }
        masks[i] = mask
    }
    maxProd := 0
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if masks[i]&masks[j] == 0 {
                product := len(words[i]) * len(words[j])
                if product > maxProd {
                    maxProd = product
                }
            }
        }
    }
    return maxProd
}