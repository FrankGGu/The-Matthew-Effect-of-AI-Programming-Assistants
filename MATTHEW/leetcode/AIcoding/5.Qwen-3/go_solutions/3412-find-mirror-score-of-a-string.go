package leetcode

func findMirrorScore(s string) int {
    n := len(s)
    score := 0
    for i := 0; i < n/2; i++ {
        if s[i] == s[n-1-i] {
            score++
        }
    }
    return score
}