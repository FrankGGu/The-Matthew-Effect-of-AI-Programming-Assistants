package main

func lexSmallestString(s string, a int) string {
    n := len(s)
    minStr := s

    for i := 0; i < n; i++ {
        if i%2 == 0 {
            for j := 0; j < 10; j++ {
                if (s[i] - '0' + j) % 10 == 0 {
                    newS := []byte(s)
                    newS[i] = byte('0' + j)
                    for k := i + 1; k < n; k++ {
                        if k%2 == 1 {
                            newS[k] = byte('0' + (int(newS[k]-'0') + j) % 10)
                        }
                    }
                    current := string(newS)
                    if current < minStr {
                        minStr = current
                    }
                }
            }
        } else {
            for j := 0; j < 10; j++ {
                if (s[i] - '0' + j) % 10 == 0 {
                    newS := []byte(s)
                    newS[i] = byte('0' + j)
                    for k := i + 1; k < n; k++ {
                        if k%2 == 0 {
                            newS[k] = byte('0' + (int(newS[k]-'0') + j) % 10)
                        }
                    }
                    current := string(newS)
                    if current < minStr {
                        minStr = current
                    }
                }
            }
        }
    }

    return minStr
}