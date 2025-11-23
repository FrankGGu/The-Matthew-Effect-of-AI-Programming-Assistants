import "math"

func findPermutationDifference(s string, t string) int {
    sCharIndices := make(map[rune]int)
    n := len(s)

    for i := 0; i < n; i++ {
        sCharIndices[rune(s[i])] = i
    }

    totalDifference := 0

    for j := 0; j < n; j++ {
        char := rune(t[j])
        sIndex := sCharIndices[char]
        tIndex := j
        totalDifference += int(math.Abs(float64(sIndex - tIndex)))
    }

    return totalDifference
}