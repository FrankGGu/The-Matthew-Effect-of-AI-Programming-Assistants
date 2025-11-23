func stoneGameII(piles []int) int {
    n := len(piles)
    if n == 0 {
        return 0
    }

    // suffixSum[i] stores the sum of piles from index i to n-1
    suffixSum := make([]int, n)
    suffixSum[n-