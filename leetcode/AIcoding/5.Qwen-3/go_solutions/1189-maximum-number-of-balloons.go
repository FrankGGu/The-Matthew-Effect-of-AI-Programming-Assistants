package main

func maxNumberOfBalloons(text string) int {
    count := make(map[rune]int)
    for _, c := range text {
        count[c]++
    }
    return min(count['b'], min(count['a'], min(count['l']/2, min(count['o']/2, count['n']))))
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}