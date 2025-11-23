package main

func sortVowels(s string) string {
    vowels := []rune{'a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'}
    vowelSet := make(map[rune]bool)
    for _, v := range vowels {
        vowelSet[v] = true
    }

    var vowelsInString []rune
    for _, c := range s {
        if vowelSet[c] {
            vowelsInString = append(vowelsInString, c)
        }
    }

    sort.Slice(vowelsInString, func(i, j int) bool {
        return vowelsInString[i] < vowelsInString[j]
    })

    result := []rune(s)
    idx := 0
    for i := range result {
        if vowelSet[result[i]] {
            result[i] = vowelsInString[idx]
            idx++
        }
    }

    return string(result)
}