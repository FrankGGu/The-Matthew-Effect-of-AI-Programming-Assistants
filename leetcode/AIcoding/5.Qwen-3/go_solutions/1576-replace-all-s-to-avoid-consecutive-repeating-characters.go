package main

func modifyString(s string) string {
    runes := []rune(s)
    for i := 0; i < len(runes); i++ {
        if runes[i] == '?' {
            for c := 'a'; c <= 'z'; c++ {
                if (i == 0 || runes[i-1] != c) && (i == len(runes)-1 || runes[i+1] != c) {
                    runes[i] = c
                    break
                }
            }
        }
    }
    return string(runes)
}