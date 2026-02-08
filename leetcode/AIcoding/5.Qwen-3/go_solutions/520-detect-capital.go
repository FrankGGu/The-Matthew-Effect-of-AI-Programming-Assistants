package main

func detectCapitalFollows(word string) bool {
    if len(word) <= 1 {
        return true
    }
    first := word[0]
    if first >= 'A' && first <= 'Z' {
        second := word[1]
        if second >= 'A' && second <= 'Z' {
            for i := 2; i < len(word); i++ {
                if word[i] >= 'a' && word[i] <= 'z' {
                    return false
                }
            }
        } else {
            for i := 2; i < len(word); i++ {
                if word[i] >= 'A' && word[i] <= 'Z' {
                    return false
                }
            }
        }
    } else {
        for i := 1; i < len(word); i++ {
            if word[i] >= 'A' && word[i] <= 'Z' {
                return false
            }
        }
    }
    return true
}