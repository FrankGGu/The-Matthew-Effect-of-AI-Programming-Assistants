func maximumScore(s string, part1 string, part2 string) int {
    maxScore := 0
    n := len(s)

    for i := 0; i < n; i++ {
        for j := i; j < n; j++ {
            substr := s[i:j+1]
            score := 0

            for k := 0; k < len(substr); k++ {
                if strings.HasPrefix(substr[k:], part1) {
                    score++
                    k += len(part1) - 1
                } else if strings.HasPrefix(substr[k:], part2) {
                    score++
                    k += len(part2) - 1
                }
            }

            if score > maxScore {
                maxScore = score
            }
        }
    }

    return maxScore
}