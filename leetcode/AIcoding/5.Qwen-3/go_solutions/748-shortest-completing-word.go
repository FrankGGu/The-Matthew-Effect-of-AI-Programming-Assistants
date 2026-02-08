package main

func shortestCompletingWords(licensePlate string, words []string) []string {
    licenseCount := make([]int, 26)
    for _, c := range licensePlate {
        if c >= 'a' && c <= 'z' {
            licenseCount[c-'a']++
        } else if c >= 'A' && c <= 'Z' {
            licenseCount[c-'A']++
        }
    }

    result := []string{}
    for _, word := range words {
        wordCount := make([]int, 26)
        for _, c := range word {
            if c >= 'a' && c <= 'z' {
                wordCount[c-'a']++
            } else if c >= 'A' && c <= 'Z' {
                wordCount[c-'A']++
            }
        }

        valid := true
        for i := 0; i < 26; i++ {
            if licenseCount[i] > wordCount[i] {
                valid = false
                break
            }
        }

        if valid {
            result = append(result, word)
        }
    }

    // Sort the result by length, then lexicographically
    sort.Slice(result, func(i, j int) bool {
        if len(result[i]) != len(result[j]) {
            return len(result[i]) < len(result[j])
        }
        return result[i] < result[j]
    })

    return result
}