package main

func countVowelStrings(n int) int {
    a, e, i, o, u := 1, 1, 1, 1, 1
    for j := 2; j <= n; j++ {
        a = a + e + i + o + u
        e = e + i + o + u
        i = i + o + u
        o = o + u
        u = u
    }
    return a + e + i + o + u
}