package main

func findRepeatedDnaSequences(s string) []string {
    seen := make(map[string]bool)
    result := []string{}
    for i := 0; i <= len(s)-10; i++ {
        substr := s[i : i+10]
        if seen[substr] {
            continue
        }
        seen[substr] = true
        if strings.Count(s, substr) > 1 {
            result = append(result, substr)
        }
    }
    return result
}