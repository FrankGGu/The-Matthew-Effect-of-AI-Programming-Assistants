package main

func rankTeams(votes []string) []byte {
    if len(votes) == 0 {
        return []byte{}
    }

    count := make(map[byte][26]int)
    for _, vote := range votes {
        for i, c := range vote {
            count[byte(c)][i]++
        }
    }

    sorted := make([]byte, len(count))
    i := 0
    for c := range count {
        sorted[i] = c
        i++
    }

    sort.Slice(sorted, func(i, j int) bool {
        a, b := sorted[i], sorted[j]
        for k := 0; k < 26; k++ {
            if count[a][k] != count[b][k] {
                return count[a][k] > count[b][k]
            }
        }
        return a < b
    })

    return sorted
}