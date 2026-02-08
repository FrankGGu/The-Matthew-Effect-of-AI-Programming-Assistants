func minSteps(s string, t string) int {
    count := make([]int, 26)
    for _, ch := range s {
        count[ch-'a']++
    }
    for _, ch := range t {
        count[ch-'a']--
    }
    steps := 0
    for _, v := range count {
        steps += abs(v)
    }
    return steps
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}