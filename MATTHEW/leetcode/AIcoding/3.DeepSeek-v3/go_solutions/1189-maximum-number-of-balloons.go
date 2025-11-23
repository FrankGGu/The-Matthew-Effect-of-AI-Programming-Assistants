func maxNumberOfBalloons(text string) int {
    count := make(map[rune]int)
    for _, c := range text {
        count[c]++
    }

    min := count['b']
    if count['a'] < min {
        min = count['a']
    }
    if count['l']/2 < min {
        min = count['l']/2
    }
    if count['o']/2 < min {
        min = count['o']/2
    }
    if count['n'] < min {
        min = count['n']
    }

    return min
}