import "sort"

func maxEnvelopes(envelopes [][]int) int {
    sort.Slice(envelopes, func(i, j int) bool {
        if envelopes[i][0] == envelopes[j][0] {
            return envelopes[i][1] > envelopes[j][1]
        }
        return envelopes[i][0] < envelopes[j][0]
    })

    dp := []int{}
    for _, env := range envelopes {
        h := env[1]
        idx := sort.SearchInts(dp, h)
        if idx == len(dp) {
            dp = append(dp, h)
        } else {
            dp[idx] = h
        }
    }
    return len(dp)
}