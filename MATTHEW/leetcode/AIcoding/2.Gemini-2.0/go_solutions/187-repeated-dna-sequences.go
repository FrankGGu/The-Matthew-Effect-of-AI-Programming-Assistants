func findRepeatedDnaSequences(s string) []string {
    n := len(s)
    if n < 10 {
        return []string{}
    }

    seen := make(map[string]int)
    result := make([]string, 0)

    for i := 0; i <= n-10; i++ {
        sub := s[i:i+10]
        seen[sub]++
        if seen[sub] == 2 {
            result = append(result, sub)
        }
    }

    return result
}