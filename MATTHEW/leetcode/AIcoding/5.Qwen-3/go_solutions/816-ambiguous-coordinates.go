package main

func ambiguousCoordinates(s string) []string {
    s = s[1 : len(s)-1]
    var result []string
    for i := 1; i < len(s); i++ {
        left := s[:i]
        right := s[i:]
        var leftOptions []string
        var rightOptions []string
        if isValid(left) {
            leftOptions = append(leftOptions, left)
        }
        for j := 1; j < len(left); j++ {
            if isValid(left[:j] + "." + left[j:]) {
                leftOptions = append(leftOptions, left[:j] + "." + left[j:])
            }
        }
        if isValid(right) {
            rightOptions = append(rightOptions, right)
        }
        for j := 1; j < len(right); j++ {
            if isValid(right[:j] + "." + right[j:]) {
                rightOptions = append(rightOptions, right[:j] + "." + right[j:])
            }
        }
        for _, l := range leftOptions {
            for _, r := range rightOptions {
                result = append(result, "(" + l + ", " + r + ")")
            }
        }
    }
    return result
}

func isValid(num string) bool {
    if len(num) == 0 {
        return false
    }
    if num[0] == '0' && len(num) > 1 {
        if num[1] == '.' {
            return true
        }
        return false
    }
    return true
}