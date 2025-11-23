func isItPossible(word1 string, word2 string) bool {
    count1 := make(map[rune]int)
    count2 := make(map[rune]int)

    for _, c := range word1 {
        count1[c]++
    }
    for _, c := range word2 {
        count2[c]++
    }

    for c1, cnt1 := range count1 {
        for c2, cnt2 := range count2 {
            newCount1 := make(map[rune]int)
            newCount2 := make(map[rune]int)

            for k, v := range count1 {
                newCount1[k] = v
            }
            for k, v := range count2 {
                newCount2[k] = v
            }

            newCount1[c1]--
            if newCount1[c1] == 0 {
                delete(newCount1, c1)
            }
            newCount1[c2]++

            newCount2[c2]--
            if newCount2[c2] == 0 {
                delete(newCount2, c2)
            }
            newCount2[c1]++

            if len(newCount1) == len(newCount2) {
                return true
            }
        }
    }

    return false
}