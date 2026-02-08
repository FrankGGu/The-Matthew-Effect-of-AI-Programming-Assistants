package main

func checkIfCanBreak(s1 string, s2 string) bool {
    sort.Slice([]rune(s1), func(i, j int) bool { return s1[i] < s2[j] })
    sort.Slice([]rune(s2), func(i, j int) bool { return s2[i] < s2[j] })
    for i := 0; i < len(s1); i++ {
        if s1[i] < s2[i] {
            return false
        }
    }
    return true
}