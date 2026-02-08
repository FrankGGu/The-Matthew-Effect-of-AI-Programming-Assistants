func minimumTimeToInitialState(word string, k int) int {
    n := len(word)
    for t := 1; t <= n/k; t++ {
        match := true
        for i := t * k; i < n; i++ {
            if word[i] != word[i - t * k] {
                match = false
                break
            }
        }
        if match {
            return t
        }
    }
    return (n + k - 1) / k
}