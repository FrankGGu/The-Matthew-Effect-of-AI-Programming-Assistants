package main

func maximumScore(s string, A []int) int {
    n := len(s)
    type pair struct {
        idx int
        val int
    }
    var pairs []pair
    for i := 0; i < len(A); i++ {
        pairs = append(pairs, pair{i, A[i]})
    }
    sort.Slice(pairs, func(i, j int) bool {
        return pairs[i].val > pairs[j].val
    })
    score := 0
    used := make([]bool, n)
    for _, p := range pairs {
        idx := p.idx
        val := p.val
        if idx > 0 && !used[idx-1] && s[idx-1] == 'A' && s[idx] == 'B' {
            score += val
            used[idx-1] = true
            used[idx] = true
        } else if idx < n-1 && !used[idx+1] && s[idx] == 'A' && s[idx+1] == 'B' {
            score += val
            used[idx] = true
            used[idx+1] = true
        }
    }
    return score
}