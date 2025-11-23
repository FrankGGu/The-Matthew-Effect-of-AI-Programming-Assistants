func findRepeatedDnaSequences(s string) []string {
    seen := make(map[string]int)
    result := []string{}

    for i := 0; i <= len(s)-10; i++ {
        seq := s[i:i+10]
        seen[seq]++
        if seen[seq] == 2 {
            result = append(result, seq)
        }
    }

    return result
}