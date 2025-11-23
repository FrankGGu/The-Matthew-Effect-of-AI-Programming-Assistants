func maxScore(s string) int {
    n := len(s)

    zerosLeft := 0
    onesRight := 0

    // Initialize for the first split point: left = s[0], right = s[1...n-1]
    if s[0] == '0' {
        zerosLeft = 1
    }

    for i := 1; i < n; i++ {
        if s[i] == '1' {
            onesRight++
        }
    }

    maxScore := zerosLeft + onesRight

    // Iterate through subsequent split points.
    // The loop variable 'i' represents the end index of the left part.
    // So, for each 'i', the split is s[0...i] | s[i+1...n-1].
    // 'i' goes from 1 (split after s[1]) up to n-2 (split before s[n-1]).
    for i := 1; i < n-1; i++ {
        if s[i] == '0' {
            zerosLeft++
        } else { // s[i] == '1'
            onesRight--
        }

        currentScore := zerosLeft + onesRight
        if currentScore > maxScore {
            maxScore = currentScore
        }
    }

    return maxScore
}