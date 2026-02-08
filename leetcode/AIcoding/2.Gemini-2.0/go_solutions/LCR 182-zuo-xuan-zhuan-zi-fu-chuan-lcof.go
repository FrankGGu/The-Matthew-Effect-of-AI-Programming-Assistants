func getHint(secret string, guess string) string {
    bulls := 0
    cows := 0
    secretCounts := make(map[rune]int)
    guessCounts := make(map[rune]int)

    for i, r := range secret {
        if rune(guess[i]) == r {
            bulls++
        } else {
            secretCounts[r]++
            guessCounts[rune(guess[i])]++
        }
    }

    for r, count := range guessCounts {
        if secretCounts[r] > 0 {
            cows += min(count, secretCounts[r])
        }
    }

    return string(strconv.Itoa(bulls)) + "A" + string(strconv.Itoa(cows)) + "B"
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

import "strconv"