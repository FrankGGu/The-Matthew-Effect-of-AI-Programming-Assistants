func maxUniqueSplit(s string) int {
    max := 0
    backtrack(s, 0, make(map[string]bool), &max)
    return max
}

func backtrack(s string, start int, seen map[string]bool, max *int) {
    if start == len(s) {
        if len(seen) > *max {
            *max = len(seen)
        }
        return
    }

    for end := start + 1; end <= len(s); end++ {
        substr := s[start:end]
        if !seen[substr] {
            seen[substr] = true
            backtrack(s, end, seen, max)
            delete(seen, substr)
        }
    }
}