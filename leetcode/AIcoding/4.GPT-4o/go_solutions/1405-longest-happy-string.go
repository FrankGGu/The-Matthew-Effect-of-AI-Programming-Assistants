func longestDiverseString(a int, b int, c int) string {
    result := ""
    count := []int{a, b, c}
    chars := []byte{'a', 'b', 'c'}

    for {
        added := false
        for i := 0; i < 3; i++ {
            if count[i] > 0 && (len(result) < 2 || result[len(result)-1] != chars[i] || result[len(result)-2] != chars[i]) {
                result += string(chars[i])
                count[i]--
                added = true
                break
            }
        }
        if !added {
            break
        }
    }

    return result
}