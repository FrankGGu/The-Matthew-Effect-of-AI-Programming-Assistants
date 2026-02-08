import "strings"

func countKeyChanges(s string) int {
    if len(s) < 2 {
        return 0
    }

    changes := 0
    // Convert the entire string to lowercase once to simplify comparisons
    lowerS := strings.ToLower(s)

    for i := 1; i < len(lowerS); i++ {
        if lowerS[i] != lowerS[i-1] {
            changes++
        }
    }

    return changes
}