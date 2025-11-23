func maxDivScore(nums []int, divisors []int) int {
    maxScore := 0
    result := 0
    for _, d := range divisors {
        score := 0
        for _, n := range nums {
            if n%d == 0 {
                score++
            }
        }
        if score > maxScore || (score == maxScore && d > result) {
            maxScore = score
            result = d
        }
    }
    return result
}