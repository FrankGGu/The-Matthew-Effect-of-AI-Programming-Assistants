func minimumBuckets(hamsters string) int {
    n := len(hamsters)
    buckets := 0
    hamstersRunes := []rune(hamsters)

    for i := 0; i < n; i++ {
        if hamstersRunes[i] == 'H' {
            if i > 0 && hamstersRunes[i-1] == 'B' {
                continue
            }
            if i < n-1 && hamstersRunes[i+1] == '.' {
                hamstersRunes[i+1] = 'B'
                buckets++
            } else if i > 0 && hamstersRunes[i-1] == '.' {
                hamstersRunes[i-1] = 'B'
                buckets++
            } else {
                return -1
            }
        }
    }
    return buckets
}