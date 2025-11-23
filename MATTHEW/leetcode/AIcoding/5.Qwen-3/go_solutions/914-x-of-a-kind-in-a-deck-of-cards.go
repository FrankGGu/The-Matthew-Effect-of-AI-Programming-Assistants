package main

func hasGroupsSizeX(deck []int) bool {
    count := make(map[int]int)
    for _, card := range deck {
        count[card]++
    }

    var gcdVal int = -1
    for _, v := range count {
        if gcdVal == -1 {
            gcdVal = v
        } else {
            gcdVal = gcd(gcdVal, v)
        }
    }

    return gcdVal >= 2
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}