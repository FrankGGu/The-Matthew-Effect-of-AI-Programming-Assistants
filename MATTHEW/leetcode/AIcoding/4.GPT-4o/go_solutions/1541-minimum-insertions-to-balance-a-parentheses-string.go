func minInsertions(s string) int {
    leftCount := 0
    rightCount := 0
    n := len(s)

    for i := 0; i < n; i++ {
        if s[i] == '(' {
            leftCount++
        } else {
            if i+1 < n && s[i] == ')' && s[i+1] == ')' {
                rightCount++
                i++
            } else if s[i] == ')' {
                rightCount++
            }
        }
    }

    return leftCount * 2 - rightCount
}