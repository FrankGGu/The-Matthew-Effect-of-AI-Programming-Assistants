func countVowelSubstrings(s string) int {
    vowels := "aeiou"
    vowelSet := make(map[byte]bool)
    for i := 0; i < len(vowels); i++ {
        vowelSet[vowels[i]] = true
    }

    count := 0
    n := len(s)

    for i := 0; i < n; i++ {
        if !vowelSet[s[i]] {
            continue
        }

        seen := make(map[byte]bool)
        for j := i; j < n; j++ {
            if !vowelSet[s[j]] {
                break
            }
            seen[s[j]] = true
            if len(seen) == 5 {
                count++
            }
        }
    }

    return count
}