func maxLength(arr []string) int {
    maxLen := 0
    backtrack(arr, 0, "", &maxLen)
    return maxLen
}

func backtrack(arr []string, index int, current string, maxLen *int) {
    if index == len(arr) {
        if unique(current) && len(current) > *maxLen {
            *maxLen = len(current)
        }
        return
    }

    backtrack(arr, index+1, current, maxLen)
    backtrack(arr, index+1, current+arr[index], maxLen)
}

func unique(s string) bool {
    seen := make(map[rune]bool)
    for _, c := range s {
        if seen[c] {
            return false
        }
        seen[c] = true
    }
    return true
}