func maxNumberOfBalloons(text string) int {
    count := make(map[rune]int)
    for _, ch := range text {
        count[ch]++
    }

    countB := count['b']
    countA := count['a']
    countL := count['l'] / 2
    countO := count['o'] / 2
    countN := count['n']

    return min(min(countB, countA), min(countL, min(countO, countN)))
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}