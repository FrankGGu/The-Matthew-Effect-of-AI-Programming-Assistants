package main

func minimumPushes(word string) int {
    count := make(map[rune]int)
    for _, c := range word {
        count[c]++
    }

    type pair struct {
        freq int
        ch   rune
    }

    var pairs []pair
    for ch, freq := range count {
        pairs = append(pairs, pair{freq, ch})
    }

    sort.Slice(pairs, func(i, j int) bool {
        return pairs[i].freq > pairs[j].freq
    })

    pushes := 0
    for i, p := range pairs {
        pushes += p.freq * ((i / 8) + 1)
    }

    return pushes
}