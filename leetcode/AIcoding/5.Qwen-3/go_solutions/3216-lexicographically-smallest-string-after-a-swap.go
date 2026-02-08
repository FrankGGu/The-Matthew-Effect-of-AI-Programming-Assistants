package main

func lexSmallestString(s string, a int) string {
    n := len(s)
    sRunes := []rune(s)
    for i := 0; i < n; i++ {
        if i%2 == 0 {
            for j := i + 1; j < n; j++ {
                if (sRunes[j]-sRunes[i])%a == 0 && sRunes[j] < sRunes[i] {
                    sRunes[i], sRunes[j] = sRunes[j], sRunes[i]
                    return string(sRunes)
                }
            }
        } else {
            for j := i + 1; j < n; j++ {
                if (sRunes[j]-sRunes[i])%a == 0 && sRunes[j] < sRunes[i] {
                    sRunes[i], sRunes[j] = sRunes[j], sRunes[i]
                    return string(sRunes)
                }
            }
        }
    }
    return string(sRunes)
}