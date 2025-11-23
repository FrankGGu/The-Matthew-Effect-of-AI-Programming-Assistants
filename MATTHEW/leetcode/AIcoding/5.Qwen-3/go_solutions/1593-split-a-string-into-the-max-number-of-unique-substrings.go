package main

func maxUniqueSplit(s string) int {
    var backtrack func(int, map[string]bool, int) int
    backtrack = func(start int, seen map[string]bool, count int) int {
        if start == len(s) {
            return count
        }
        maxCount := 0
        for end := start + 1; end <= len(s); end++ {
            substr := s[start:end]
            if !seen[substr] {
                seen[substr] = true
                res := backtrack(end, seen, count+1)
                if res > maxCount {
                    maxCount = res
                }
                seen[substr] = false
            }
        }
        return maxCount
    }
    return backtrack(0, make(map[string]bool), 0)
}