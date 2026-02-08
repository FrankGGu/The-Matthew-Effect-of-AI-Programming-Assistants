package main

func areDigitsEqual(s string) bool {
    count := make(map[rune]int)
    for _, c := range s {
        count[c]++
    }
    values := make([]int, 0, len(count))
    for _, v := range count {
        values = append(values, v)
    }
    for i := 1; i < len(values); i++ {
        if values[i] != values[0] {
            return false
        }
    }
    return true
}