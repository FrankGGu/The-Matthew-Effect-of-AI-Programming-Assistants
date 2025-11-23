package main

func addSpaces(s string, spaces []int) string {
    var result []rune
    n := len(s)
    m := len(spaces)
    i := 0
    j := 0
    for i < n {
        if j < m && i == spaces[j] {
            result = append(result, ' ')
            j++
        }
        result = append(result, rune(s[i]))
        i++
    }
    return string(result)
}