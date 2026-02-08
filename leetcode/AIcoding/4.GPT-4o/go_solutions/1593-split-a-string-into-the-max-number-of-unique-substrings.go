func maxUniqueSplit(s string) int {
    maxCount := 0
    uniqueSubstrings := make(map[string]struct{})

    var backtrack func(start int, count int)
    backtrack = func(start int, count int) {
        if start == len(s) {
            if count > maxCount {
                maxCount = count
            }
            return
        }

        for end := start + 1; end <= len(s); end++ {
            substring := s[start:end]
            if _, exists := uniqueSubstrings[substring]; !exists {
                uniqueSubstrings[substring] = struct{}{}
                backtrack(end, count+1)
                delete(uniqueSubstrings, substring)
            }
        }
    }

    backtrack(0, 0)
    return maxCount
}