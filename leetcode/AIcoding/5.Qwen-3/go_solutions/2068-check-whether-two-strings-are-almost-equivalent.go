package main

func isAlmostEqual(word1 string, word2 string) bool {
    count1 := make([]int, 26)
    count2 := make([]int, 26)

    for _, c := range word1 {
        count1[c-'a']++
    }

    for _, c := range word2 {
        count2[c-'a']++
    }

    for i := 0; i < 26; i++ {
        if abs(count1[i] - count2[i]) > 3 {
            return false
        }
    }

    return true
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}