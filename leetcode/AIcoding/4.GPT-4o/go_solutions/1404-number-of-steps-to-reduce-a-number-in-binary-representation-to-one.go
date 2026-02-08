func numSteps(s string) int {
    steps := 0
    carry := 0

    for i := len(s) - 1; i > 0; i-- {
        steps++
        if s[i] == '1' {
            steps++
        }
    }

    return steps
}