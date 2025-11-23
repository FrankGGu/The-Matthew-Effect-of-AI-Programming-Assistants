package main

func mostFrequentVowelAndConsonant(s string) []byte {
    vowels := map[byte]bool{'a': true, 'e': true, 'i': true, 'o': true, 'u': true}
    vowelCount := make(map[byte]int)
    consonantCount := make(map[byte]int)
    maxVowel := 0
    maxConsonant := 0
    var result []byte

    for i := 0; i < len(s); i++ {
        c := s[i]
        if vowels[c] {
            vowelCount[c]++
            if vowelCount[c] > maxVowel {
                maxVowel = vowelCount[c]
            }
        } else {
            consonantCount[c]++
            if consonantCount[c] > maxConsonant {
                maxConsonant = consonantCount[c]
            }
        }
    }

    for c := range vowelCount {
        if vowelCount[c] == maxVowel {
            result = append(result, c)
        }
    }

    for c := range consonantCount {
        if consonantCount[c] == maxConsonant {
            result = append(result, c)
        }
    }

    return result
}