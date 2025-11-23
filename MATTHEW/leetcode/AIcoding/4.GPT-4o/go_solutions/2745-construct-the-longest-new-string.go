func longestNewString(s string) string {
    count := make(map[rune]int)
    for _, char := range s {
        count[char]++
    }

    var result []rune
    for char, c := range count {
        if c > 0 {
            result = append(result, char)
        }
    }

    sort.Slice(result, func(i, j int) bool {
        return result[i] < result[j]
    })

    return string(result)
}