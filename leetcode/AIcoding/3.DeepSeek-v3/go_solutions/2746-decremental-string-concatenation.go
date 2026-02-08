func minimizeConcatenatedLength(words []string) int {
    n := len(words)
    if n == 0 {
        return 0
    }

    memo := make([][26][26]int, n)
    for i := range memo {
        for j := 0; j < 26; j++ {
            for k := 0; k < 26; k++ {
                memo[i][j][k] = -1
            }
        }
    }

    firstChar := int(words[0][0] - 'a')
    lastChar := int(words[0][len(words[0])-1] - 'a')
    length := len(words[0])

    var dp func(int, int, int) int
    dp = func(index, first, last int) int {
        if index == n {
            return 0
        }
        if memo[index][first][last] != -1 {
            return memo[index][first][last]
        }

        currentFirst := int(words[index][0] - 'a')
        currentLast := int(words[index][len(words[index])-1] - 'a')
        currentLen := len(words[index])

        // Option 1: place current word after previous
        option1 := currentLen + dp(index+1, first, currentLast)
        if last == currentFirst {
            option1--
        }

        // Option 2: place current word before previous
        option2 := currentLen + dp(index+1, currentFirst, last)
        if currentLast == first {
            option2--
        }

        memo[index][first][last] = min(option1, option2)
        return memo[index][first][last]
    }

    return length + dp(1, firstChar, lastChar)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}