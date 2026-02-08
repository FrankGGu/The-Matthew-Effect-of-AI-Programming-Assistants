func maxNumberOfBalloons(text string) int {
    count := make(map[rune]int)
    for _, r := range text {
        count[r]++
    }

    b := count['b']
    a := count['a']
    l := count['l'] / 2
    o := count['o'] / 2
    n := count['n']

    min := b
    if a < min {
        min = a
    }
    if l < min {
        min = l
    }
    if o < min {
        min = o
    }
    if n < min {
        min = n
    }

    return min
}