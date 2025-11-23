func maximizeFunctionValue(parent []int, values []int, k_val int) int64 {
    n := len(parent)
    maxK := k_val // Use k_val as the upper limit for k

    // Binary lifting setup
    // nextPlayer[j][i] stores the player reached after 2^j