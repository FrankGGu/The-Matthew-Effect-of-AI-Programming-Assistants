func minSteps(s string, t string) int {
    count := [26]int{}
    for _, ch := range s {
        count[ch-'a']++
    }
    for _, ch := range t {
        count[ch-'a']--
    }
    steps := 0
    for _, c := range count {
        if c > 0 {
            steps += c
        }
    }
    return steps
}