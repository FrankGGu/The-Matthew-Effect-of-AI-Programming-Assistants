func expressiveWords(S string, words []string) int {
    count := 0
    sGroups := groupString(S)

    for _, word := range words {
        wGroups := groupString(word)
        if len(sGroups) != len(wGroups) {
            continue
        }
        match := true
        for i := 0; i < len(sGroups); i++ {
            sChar, sCnt := sGroups[i][0], sGroups[i][1]
            wChar, wCnt := wGroups[i][0], wGroups[i][1]
            if sChar != wChar {
                match = false
                break
            }
            if sCnt < wCnt || (sCnt < 3 && sCnt != wCnt) {
                match = false
                break
            }
        }
        if match {
            count++
        }
    }
    return count
}

func groupString(s string) [][]int {
    if len(s) == 0 {
        return [][]int{}
    }
    groups := [][]int{}
    prev := s[0]
    count := 1
    for i := 1; i < len(s); i++ {
        if s[i] == prev {
            count++
        } else {
            groups = append(groups, []int{int(prev), count})
            prev = s[i]
            count = 1
        }
    }
    groups = append(groups, []int{int(prev), count})
    return groups
}