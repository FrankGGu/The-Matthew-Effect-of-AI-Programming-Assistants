package main

func stringSequence(target string) []string {
    result := []string{}
    current := ""
    for i := 0; i < len(target); i++ {
        current += "a"
        result = append(result, current)
        for current != target[:i+1] {
            next := []rune(current)
            for j := len(next) - 1; j >= 0; j-- {
                if next[j] < rune('z') {
                    next[j]++
                    break
                } else {
                    next[j] = 'a'
                }
            }
            current = string(next)
            result = append(result, current)
        }
    }
    return result
}