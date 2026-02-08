func consecutiveNumbersSum(N int) int {
    count := 0
    for k := 1; k*(k+1)/2 <= N; k++ {
        if (N-k*(k+1)/2)%k == 0 {
            count++
        }
    }
    return count
}