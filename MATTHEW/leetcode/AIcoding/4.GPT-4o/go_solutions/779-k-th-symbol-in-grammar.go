func kthGrammar(N int, K int) int {
    if N == 1 && K == 1 {
        return 0
    }
    mid := 1 << (N - 2)
    if K <= mid {
        return kthGrammar(N-1, K)
    }
    return 1 - kthGrammar(N-1, K-mid)
}