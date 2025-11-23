func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func minimumTeachings(n int, languages [][]int, friendships [][]int) int {
    needToLearn := make(map[int]map[int]bool)
    for i := 0; i < len(friendships); i++ {
        u := friendships[i][0] - 1
        v := friendships[i][1] - 1
        canCommunicate := false
        for _, langU := range languages[u] {
            for _, langV := range languages[v] {
                if langU == langV {
                    canCommunicate = true
                    break
                }
            }
            if canCommunicate {
                break
            }
        }
        if !canCommunicate {
            if needToLearn[u] == nil {
                needToLearn[u] = make(map[int]bool)
            }
            if needToLearn[v] == nil {
                needToLearn[v] = make(map[int]bool)
            }
            needToLearn[u][i] = true
            needToLearn[v][i] = true
        }
    }

    ans := len(languages)
    for lang := 1; lang <= n; lang++ {
        count := 0
        learned := make(map[int]bool)
        for person := range needToLearn {
            needLearn := false
            for _, l := range languages[person] {
                if l == lang {
                    needLearn = false
                    break
                }
                needLearn = true
            }
            if needLearn {
                if !learned[person] {
                    count++
                    learned[person] = true
                }
            }
        }
        ans = min(ans, count)
    }

    return ans
}