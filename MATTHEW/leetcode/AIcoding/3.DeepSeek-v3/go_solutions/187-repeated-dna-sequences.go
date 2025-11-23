func findRepeatedDnaSequences(s string) []string {
    seen := make(map[string]int)
    res := make([]string, 0)

    for i := 0; i <= len(s)-10; i++ {
        sub := s[i:i+10]
        seen[sub]++
        if seen[sub] == 2 {
            res = append(res, sub)
        }
    }

    return res
}