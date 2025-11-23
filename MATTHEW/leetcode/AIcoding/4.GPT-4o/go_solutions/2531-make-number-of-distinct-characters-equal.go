func isPossible(s1 string, s2 string) bool {
    count1 := make(map[rune]int)
    count2 := make(map[rune]int)

    for _, ch := range s1 {
        count1[ch]++
    }
    for _, ch := range s2 {
        count2[ch]++
    }

    distinct1 := len(count1)
    distinct2 := len(count2)

    if distinct1 == distinct2 {
        return true
    }

    if distinct1 < distinct2 {
        count1, count2 = count2, count1
        distinct1, distinct2 = distinct2, distinct1
    }

    if distinct1 > distinct2 {
        diff := distinct1 - distinct2
        for _, cnt := range count1 {
            if cnt > 1 {
                diff--
                if diff == 0 {
                    return true
                }
            }
        }
    }

    return false
}