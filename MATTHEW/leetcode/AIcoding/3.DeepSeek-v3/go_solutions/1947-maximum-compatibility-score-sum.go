func maxCompatibilitySum(students [][]int, mentors [][]int) int {
    m := len(students)
    n := len(students[0])
    maxScore := 0
    used := make([]bool, m)

    var backtrack func(int, int)
    backtrack = func(pos, score int) {
        if pos == m {
            if score > maxScore {
                maxScore = score
            }
            return
        }
        for i := 0; i < m; i++ {
            if !used[i] {
                used[i] = true
                current := 0
                for j := 0; j < n; j++ {
                    if students[pos][j] == mentors[i][j] {
                        current++
                    }
                }
                backtrack(pos+1, score+current)
                used[i] = false
            }
        }
    }

    backtrack(0, 0)
    return maxScore
}