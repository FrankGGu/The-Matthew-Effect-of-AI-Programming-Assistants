func maxCompatibilitySum(students [][]int, mentors [][]int) int {
    n := len(students)
    maxScore := 0
    var backtrack func(int, int) 
    score := make([][]int, n)

    for i := 0; i < n; i++ {
        score[i] = make([]int, n)
        for j := 0; j < n; j++ {
            score[i][j] = compatibility(students[i], mentors[j])
        }
    }

    used := make([]bool, n)
    backtrack = func(index int, currentScore int) {
        if index == n {
            if currentScore > maxScore {
                maxScore = currentScore
            }
            return
        }
        for i := 0; i < n; i++ {
            if !used[i] {
                used[i] = true
                backtrack(index + 1, currentScore + score[index][i])
                used[i] = false
            }
        }
    }

    backtrack(0, 0)
    return maxScore
}

func compatibility(student []int, mentor []int) int {
    score := 0
    for i := 0; i < len(student); i++ {
        if student[i] == mentor[i] {
            score++
        }
    }
    return score
}