func minFlipsMonoIncr(s string) int {
    ones := 0
    flips := 0
    for _, c := range s {
        if c == '1' {
            ones++
        } else {
            flips++
        }
        if flips > ones {
            flips = ones
        }
    }
    return flips
}