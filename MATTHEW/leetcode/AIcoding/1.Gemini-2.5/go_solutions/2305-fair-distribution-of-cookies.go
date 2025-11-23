func distributeCookies(cookies []int, k int) int {
    minUnfairness := 1_000_000_000 // Initialize with a sufficiently large value
    childSums := make([]int, k)   // childSums[i] stores the total size of cookies for child i

    var dfs func(cookieIndex int)
    dfs = func(cookieIndex int) {
        // Base case: All cookies have been distributed
        if cookieIndex == len(cookies) {
            currentMax := 0
            for _, sum := range childSums {
                if sum > currentMax {
                    currentMax = sum
                }
            }
            if currentMax < minUnfairness {
                minUnfairness = currentMax
            }
            return
        }

        // Recursive step: Try assigning the current cookie to each child
        for i := 0; i < k; i++ {
            // Optimization: Track if the current child was empty before assigning this cookie.
            // This is used to prune symmetric branches later.
            wasEmpty := childSums[i] == 0

            childSums[i] += cookies[cookieIndex]

            // Pruning: If the current child's sum already exceeds or equals the best unfairness found so far,
            // then this path cannot lead to a better solution.
            if childSums[i] >= minUnfairness {
                childSums[i] -= cookies[cookieIndex] // Backtrack
                continue // Try the next child
            }

            dfs(cookieIndex + 1)

            childSums[i] -= cookies[cookieIndex] // Backtrack: remove the cookie from child i

            // Optimization for identical empty children:
            // If we assigned the current cookie to an initially empty child `i`,
            // we don't need to try assigning it to any subsequent empty child `j > i`.
            // This is because those would lead to symmetric distributions (e.g., [cookie, 0, 0] vs [0, cookie, 0]).
            // By breaking, we ensure that the current cookie only fills the "first available empty slot" if one exists.
            if wasEmpty {
                break // Stop trying other children for this cookie
            }
        }
    }

    dfs(0) // Start distributing from the first cookie (index 0)

    return minUnfairness
}