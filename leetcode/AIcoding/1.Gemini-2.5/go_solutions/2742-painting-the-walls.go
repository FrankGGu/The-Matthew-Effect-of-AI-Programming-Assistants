import "math"

func paintWalls(cost []int, time []int) int {
    n := len(cost)

    // dp[j] will store the minimum cost to achieve a "net time" of j.
    // "net time" is defined as (sum of time[i] for walls painted by paid painter) - (number of walls painted by free painter).
    // We want to find the minimum cost such that the final "net time" is non-negative (>= 0).

    // The minimum possible net time is -n (if all n walls are painted by the free painter).
    // The maximum possible net time is sum(time[i]) (if all n walls are painted by the paid painter).
    // Given time[i] <= 500 and n <= 500:
    // Max sum(time[i]) can be n * 500 = 500 * 500 = 250000.
    // Min net time is -n = -500.

    // To handle negative indices, we use an offset.
    // Let `offset = n`. This maps the minimum net time `-n` to index `0`.
    // So, an actual net time `b` corresponds to index `b + offset`.
    offset := n

    // The maximum index needed will be (max_possible_net_time + offset).
    // max_possible_net_time = n * 500.
    maxIdx := (n * 500) + offset
    dpSize := maxIdx + 1 // Array size needed

    dp := make([]int, dpSize)

    // Initialize dp with a large value representing infinity.
    // Max total cost can be n * max(cost[i]) = 500 * 10^6 = 5 * 10^8.
    // math.MaxInt32 (approx 2 * 10^9) is sufficient for infinity.
    infinity := math.MaxInt32

    for i := range dp {
        dp[i] = infinity
    }

    // Base case: Before considering any walls, we have 0 cost and 0 net time.
    // This state corresponds to index `0 + offset`.
    dp[offset] = 0

    // Iterate through each wall
    for i := 0; i < n; i++ {
        currentCost := cost[i]
        currentTime := time[i]

        // Create a new DP array for the current iteration.
        // This ensures that each wall is considered exactly once (0/1 knapsack style).
        newDp := make([]int, dpSize)
        copy(newDp, dp) // Start by copying states from the previous iteration

        // Iterate through all possible previous net time states (jIdx).
        // The order of jIdx iteration (ascending or descending) does not affect correctness
        // when using a `newDp` array.
        for jIdx := 0; jIdx < dpSize; jIdx++ {
            if dp[jIdx] == infinity { // If this state was unreachable, skip
                continue
            }

            currentBalance := jIdx - offset // Convert index to actual net time balance

            // Option 1: Paid painter paints wall `i`
            // Cost increases by `currentCost`. Net time balance increases by `currentTime`.
            newBalancePaid := currentBalance + currentTime
            newIdxPaid := newBalancePaid + offset
            if newIdxPaid < dpSize { // Check if the new index is within bounds
                newDp[newIdxPaid] = min(newDp[newIdxPaid], dp[jIdx] + currentCost)
            }

            // Option 2: Free painter paints wall `i`
            // Cost does not change. Net time balance decreases by 1 (penalty for free wall).
            newBalanceFree := currentBalance - 1
            newIdxFree := newBalanceFree + offset
            if newIdxFree >= 0 { // Check if the new index is within bounds
                newDp[newIdxFree] = min(newDp[newIdxFree], dp[jIdx])
            }
        }
        dp = newDp // Update dp for the next iteration
    }

    // After processing all `n` walls, find the minimum cost among all states
    // where the final net time balance is non-negative (>= 0).
    minTotalCost := infinity
    for jIdx := offset; jIdx < dpSize; jIdx++ { // Iterate from balance 0 (index `offset`) up to max balance
        if dp[jIdx] != infinity {
            minTotalCost = min(minTotalCost, dp[jIdx])
        }
    }

    return minTotalCost
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}