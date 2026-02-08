package main

func lexSmallestString(s string, a int) string {
    n := len(s)
    sRunes := []rune(s)
    for i := 0; i < a; i++ {
        for j := 0; j < n-1; j++ {
            if sRunes[j] > sRunes[j+1] {
                sRunes[j], sRunes[j+1] = sRunes[j+1], sRunes[j]
                break
            }
        }
    }
    return string(sRunes)
}