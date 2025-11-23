import "strings"

func rotateString(s string, goal string) bool {
    if len(s) != len(goal) {
        return false
    }
    if len(s) == 0 {
        return true
    }

    return strings.Contains(s+s, goal)
}