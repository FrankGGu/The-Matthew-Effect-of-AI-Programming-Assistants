package main

func maxFactorScore(nums []int) int {
    maxScore := 0
    for _, num := range nums {
        score := 1
        for i := 2; i*i <= num; i++ {
            if num%i == 0 {
                score *= i
                if num/i != i {
                    score *= num / i
                }
            }
        }
        if score > maxScore {
            maxScore = score
        }
    }
    return maxScore
}