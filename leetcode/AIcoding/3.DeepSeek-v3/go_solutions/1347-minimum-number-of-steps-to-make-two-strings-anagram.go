func minSteps(s string, t string) int {
    count := make([]int, 26)
    for _, ch := range s {
        count[ch - 'a']++
    }
    for _, ch := range t {
        count[ch - 'a']--
    }
    steps := 0
    for _, val := range count {
        if val > 0 {
            steps += val
        }
    }
    return steps
}