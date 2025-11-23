func buddyStrings(s string, goal string) bool {
    if len(s) != len(goal) {
        return false
    }

    if s == goal {
        seen := make(map[rune]bool)
        for _, c := range s {
            if seen[c] {
                return true
            }
            seen[c] = true
        }
        return false
    }

    pairs := make([][2]rune, 0)
    for i := 0; i < len(s); i++ {
        if s[i] != goal[i] {
            pairs = append(pairs, [2]rune{rune(s[i]), rune(goal[i])})
        }
        if len(pairs) > 2 {
            return false
        }
    }

    return len(pairs) == 2 && pairs[0][0] == pairs[1][1] && pairs[0][1] == pairs[1][0]
}