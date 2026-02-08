func minimumTeachings(n int, languages [][]int, friendships [][]int) int {
    langMap := make(map[int]map[int]bool)
    for i, langs := range languages {
        user := i + 1
        langMap[user] = make(map[int]bool)
        for _, l := range langs {
            langMap[user][l] = true
        }
    }

    needTeach := make(map[int]bool)
    for _, f := range friendships {
        u1, u2 := f[0], f[1]
        canCommunicate := false
        for l := range langMap[u1] {
            if langMap[u2][l] {
                canCommunicate = true
                break
            }
        }
        if !canCommunicate {
            needTeach[u1] = true
            needTeach[u2] = true
        }
    }

    if len(needTeach) == 0 {
        return 0
    }

    langCount := make(map[int]int)
    for user := range needTeach {
        for l := range langMap[user] {
            langCount[l]++
        }
    }

    maxCount := 0
    for _, cnt := range langCount {
        if cnt > maxCount {
            maxCount = cnt
        }
    }

    return len(needTeach) - maxCount
}