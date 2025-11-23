func minOperations(word string, k int) int {
    n := len(word)
    if n == 0 || k == 0 || n < k {
        return 0
    }

    count := make([][]int, k)
    for i := range count {
        count[i] = make([]int, 26)
    }

    for i := 0; i < n; i++ {
        count[i%k][word[i]-'a']++
    }

    operations := 0
    for i := 0; i < k; i++ {
        maxFreq := 0
        for j := 0; j < 26; j++ {
            maxFreq = max(maxFreq, count[i][j])
        }
        operations += (n/k + (n%k > i)) - maxFreq
    }

    return operations
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}