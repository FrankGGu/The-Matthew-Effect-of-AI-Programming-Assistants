package main

func makeEqual(s []string) bool {
    count := make(map[rune]int)
    for _, str := range s {
        for _, c := range str {
            count[c]++
        }
    }
    for _, v := range count {
        if v%len(s) != 0 {
            return false
        }
    }
    return true
}