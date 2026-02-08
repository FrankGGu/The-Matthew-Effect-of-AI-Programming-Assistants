import "math"

func scoreOfString(s string) int {
    score := 0
    for i := 0; i < len(s)-1; i++ {
        diff := int(s[i]) - int(s[i+1])
        score += int(math.Abs(float64(diff)))
    }
    return score
}