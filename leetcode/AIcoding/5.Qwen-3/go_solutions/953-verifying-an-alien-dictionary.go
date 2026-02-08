package main

func isAlienSorted(words []string, order string) bool {
    orderMap := make(map[rune]int)
    for i, c := range order {
        orderMap[c] = i
    }

    for i := 0; i < len(words)-1; i++ {
        word1 := words[i]
        word2 := words[i+1]
        for j := 0; j < len(word1) && j < len(word2); j++ {
            c1 := rune(word1[j])
            c2 := rune(word2[j])
            if c1 != c2 {
                if orderMap[c1] > orderMap[c2] {
                    return false
                }
                break
            }
        }
    }
    return true
}