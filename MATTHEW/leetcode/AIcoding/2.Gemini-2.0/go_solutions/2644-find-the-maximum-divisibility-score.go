func maxDivScore(nums []int, divisors []int) int {
    maxScore := -1
    ans := 1001
    for _, d := range divisors {
        score := 0
        for _, num := range nums {
            if num%d == 0 {
                score++
            }
        }
        if score > maxScore {
            maxScore = score
            ans = d
        } else if score == maxScore && d < ans {
            ans = d
        }
    }
    return ans
}