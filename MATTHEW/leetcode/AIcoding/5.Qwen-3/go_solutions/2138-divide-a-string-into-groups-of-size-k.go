package main

func splitWords(s string, k int) []string {
    result := make([]string, 0)
    for i := 0; i < len(s); i += k {
        if i+k > len(s) {
            break
        }
        result = append(result, s[i:i+k])
    }
    return result
}