package main

func minSwaps(s1 string, s2 string) int {
    a, b := 0, 0
    for i := 0; i < len(s1); i++ {
        if s1[i] != s2[i] {
            if s1[i] == 'a' {
                a++
            } else {
                b++
            }
        }
    }
    if (a + b) % 2 != 0 {
        return -1
    }
    return a/2 + b/2 + (a%2)
}