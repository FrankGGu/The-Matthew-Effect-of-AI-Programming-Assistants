func maxEnvelopes(envelopes [][]int) int {
    if len(envelopes) == 0 {
        return 0
    }

    sort.Slice(envelopes, func(i, j int) bool {
        if envelopes[i][0] == envelopes[j][0] {
            return envelopes[i][1] > envelopes[j][1]
        }
        return envelopes[i][0] < envelopes[j][0]
    })

    dp := make([]int, len(envelopes))
    size := 0

    for _, env := range envelopes {
        l, r := 0, size
        for l < r {
            mid := l + (r-l)/2
            if dp[mid] < env[1] {
                l = mid + 1
            } else {
                r = mid
            }
        }
        dp[l] = env[1]
        if l == size {
            size++
        }
    }

    return size
}