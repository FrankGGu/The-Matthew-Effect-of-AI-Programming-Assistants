func checkDistances(s string, distance []int) bool {
    firstOccurrence := make(map[rune]int)
    for i, r := range s {
        if _, ok := firstOccurrence[r]; !ok {
            firstOccurrence[r] = i
        }
    }

    for i, r := range s {
        if idx, ok := firstOccurrence[r]; ok && idx != i {
            continue
        }

        dist := distance[r-'a']
        firstIdx := firstOccurrence[r]
        secondIdx := -1
        for j := firstIdx + 1; j < len(s); j++ {
            if rune(s[j]) == r {
                secondIdx = j
                break
            }
        }

        if secondIdx == -1 && dist != 0 {
            return false
        } else if secondIdx != -1 && secondIdx - firstIdx - 1 != dist {
            return false
        }
    }

    return true
}