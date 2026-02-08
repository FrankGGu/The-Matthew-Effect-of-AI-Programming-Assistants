package main

func minimizeStringValue(s string) string {
    counts := make([]int, 26)
    for _, c := range s {
        if c != '?' {
            counts[c-'a']++
        }
    }

    res := []rune(s)
    for i := 0; i < len(res); i++ {
        if res[i] == '?' {
            for j := 0; j < 26; j++ {
                if counts[j] == 0 {
                    res[i] = rune('a' + j)
                    counts[j]++
                    break
                }
            }
        }
    }

    return string(res)
}