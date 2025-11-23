func maxDivisibilityScore(nums []int, divisors []int) int {
    maxScore := -1 
    resultDivisor := -1 

    for _, d := range divisors {
        currentScore := 0
        for _, n := range nums {
            if n % d == 0 {
                currentScore++
            }
        }

        if currentScore > maxScore {
            maxScore = currentScore
            resultDivisor = d
        } else if currentScore == maxScore {
            if d < resultDivisor {
                resultDivisor = d
            }
        }
    }

    return resultDivisor
}