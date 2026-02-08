package main

func lexSmallestString(s string, a int) string {
    n := len(s)
    sRunes := []rune(s)
    minStr := s

    for i := 0; i < n; i++ {
        if i%2 == 0 {
            for j := 0; j < 10; j++ {
                if (sRunes[i]-'0'+j)%a == 0 {
                    newS := make([]rune, n)
                    copy(newS, sRunes)
                    newS[i] = '0' + rune(j)
                    for k := i + 1; k < n; k++ {
                        if k%2 == 1 {
                            newS[k] = '0' + ((newS[k]-'0')%a)
                        }
                    }
                    if string(newS) < minStr {
                        minStr = string(newS)
                    }
                }
            }
        } else {
            for j := 0; j < 10; j++ {
                if (sRunes[i]-'0'+j)%a == 0 {
                    newS := make([]rune, n)
                    copy(newS, sRunes)
                    newS[i] = '0' + rune(j)
                    for k := i + 1; k < n; k++ {
                        if k%2 == 0 {
                            newS[k] = '0' + ((newS[k]-'0')%a)
                        }
                    }
                    if string(newS) < minStr {
                        minStr = string(newS)
                    }
                }
            }
        }
    }

    return minStr
}