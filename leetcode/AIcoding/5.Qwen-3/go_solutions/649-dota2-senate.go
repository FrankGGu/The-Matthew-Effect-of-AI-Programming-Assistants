package main

func predictPartyVictory(senate string) string {
    n := len(senate)
    q := make([]int, 0)
    for i := 0; i < n; i++ {
        q = append(q, i)
    }
    ban := make([]bool, n)
    for len(q) > 1 {
        i := q[0]
        q = q[1:]
        if ban[i] {
            continue
        }
        for j := 0; j < len(q); j++ {
            if senate[q[j]] != senate[i] {
                ban[q[j]] = true
                break
            }
        }
    }
    if senate[q[0]] == 'R' {
        return "Radiant"
    }
    return "Dire"
}