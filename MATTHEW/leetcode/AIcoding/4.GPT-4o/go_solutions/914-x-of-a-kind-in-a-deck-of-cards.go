func hasGroupsSizeX(deck []int) bool {
    count := make(map[int]int)
    for _, card := range deck {
        count[card]++
    }

    gcd := func(a, b int) int {
        if b == 0 {
            return a
        }
        return gcd(b, a%b)
    }

    result := -1
    for _, c := range count {
        if result == -1 {
            result = c
        } else {
            result = gcd(result, c)
        }
    }

    return result >= 2
}