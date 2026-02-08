func sumOfScores(s string) int64 {
    n := len(s)
    scores := make([]int64, n)
    totalScore := int64(0)

    for i := 0; i < n; i++ {
        j := i
        for j < n && s[j] == s[i] {
            j++
        }
        count := int64(j - i)
        totalScore += count * count
        scores[i] = totalScore
        i = j - 1
    }

    return totalScore
}