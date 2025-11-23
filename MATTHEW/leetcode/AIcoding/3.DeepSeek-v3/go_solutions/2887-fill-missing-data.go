func fillMissingData(products [][]int) [][]int {
    if len(products) == 0 {
        return products
    }

    n := len(products[0])
    prev := make([]int, n)
    next := make([]int, n)

    // Initialize prev with -1
    for i := range prev {
        prev[i] = -1
    }

    // Forward pass to find the previous non-zero for each zero
    for i := 0; i < len(products); i++ {
        for j := 0; j < n; j++ {
            if products[i][j] != 0 {
                prev[j] = products[i][j]
            } else if prev[j] != -1 {
                products[i][j] = prev[j]
            }
        }
    }

    // Initialize next with -1
    for i := range next {
        next[i] = -1
    }

    // Backward pass to find the next non-zero for each zero
    for i := len(products) - 1; i >= 0; i-- {
        for j := 0; j < n; j++ {
            if products[i][j] != 0 {
                next[j] = products[i][j]
            } else if next[j] != -1 {
                products[i][j] = next[j]
            } else {
                products[i][j] = 0
            }
        }
    }

    return products
}