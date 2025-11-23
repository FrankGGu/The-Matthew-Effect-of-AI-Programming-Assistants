package main

func findRepeatedDnaSequences(s string) []string {
    seen := make(map[string]bool)
    result := []string{}
    for i := 0; i <= len(s)-10; i++ {
        seq := s[i : i+10]
        if seen[seq] {
            continue
        }
        seen[seq] = true
        if strings.Count(s, seq) > 1 {
            result = append(result, seq)
        }
    }
    return result
}