func findPermutationDifference(s string, t string) int {
    indexS := make(map[rune]int)
    for i, ch := range s {
        indexS[ch] = i
    }

    diff := 0
    for i, ch := range t {
        diff += abs(i - indexS[ch])
    }
    return diff
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}