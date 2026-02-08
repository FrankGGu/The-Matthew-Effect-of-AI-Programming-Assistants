package main

func lexSmallestString(s string, a int) string {
    n := len(s)
    sBytes := []byte(s)
    for i := 0; i < n; i++ {
        if i > 0 && sBytes[i] == sBytes[i-1] {
            continue
        }
        for j := i; j < n; j++ {
            if j == i {
                if sBytes[j] != 'a' {
                    sBytes[j] = 'a'
                }
            } else {
                if (j - i) % 2 == 0 {
                    if sBytes[j] != 'a' {
                        sBytes[j] = 'a'
                    }
                } else {
                    if sBytes[j] != 'a' {
                        sBytes[j] = 'a'
                    }
                }
            }
        }
        return string(sBytes)
    }
    return string(sBytes)
}