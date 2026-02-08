func hasGroupsSizeX(deck []int) bool {
    freq := make(map[int]int)
    for _, num := range deck {
        freq[num]++
    }

    g := -1
    for _, count := range freq {
        if g == -1 {
            g = count
        } else {
            g = gcd(g, count)
        }
    }

    return g >= 2
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a % b
    }
    return a
}