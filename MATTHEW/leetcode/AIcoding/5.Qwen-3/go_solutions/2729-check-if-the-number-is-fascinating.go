package main

func isFascinating(n int) bool {
    if n < 100 || n > 999 {
        return false
    }
    s := strconv.Itoa(n) + strconv.Itoa(n*2) + strconv.Itoa(n*3)
    if len(s) != 9 {
        return false
    }
    seen := make(map[rune]bool)
    for _, c := range s {
        if seen[c] {
            return false
        }
        seen[c] = true
    }
    return true
}