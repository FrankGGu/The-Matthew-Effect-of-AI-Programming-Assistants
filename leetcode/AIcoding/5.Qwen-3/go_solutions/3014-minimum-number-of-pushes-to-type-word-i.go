package main

func minimumPushes(word string) int {
    counts := make(map[rune]int)
    for _, c := range word {
        counts[c]++
    }

    type pair struct {
        count int
        char  rune
    }

    var pairs []pair
    for c, cnt := range counts {
        pairs = append(pairs, pair{cnt, c})
    }

    sort.Slice(pairs, func(i, j int) bool {
        return pairs[i].count > pairs[j].count
    })

    pushes := 0
    for i, p := range pairs {
        pushes += p.count * ((i / 8) + 1)
    }

    return pushes
}