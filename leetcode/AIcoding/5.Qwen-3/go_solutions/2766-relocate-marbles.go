package main

func relocateMarbles(boxes string, numberOfMoves int) string {
    marbles := make([]int, 26)
    for _, c := range boxes {
        marbles[c-'a']++
    }
    for i := 0; i < numberOfMoves; i++ {
        for j := 0; j < 25; j++ {
            if marbles[j] > 0 {
                marbles[j+1] += marbles[j]
                marbles[j] = 0
            }
        }
    }
    res := ""
    for i := 0; i < 26; i++ {
        if marbles[i] > 0 {
            res += string('a' + i)
        }
    }
    return res
}