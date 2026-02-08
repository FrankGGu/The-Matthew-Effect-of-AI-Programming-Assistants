package main

func toGoatLatin(sentence string) string {
    words := strings.Split(sentence, " ")
    result := make([]string, len(words))
    vowels := map[byte]bool{'a': true, 'e': true, 'i': true, 'o': true, 'u': true, 'A': true, 'E': true, 'I': true, 'O': true, 'U': true}

    for i, word := range words {
        if vowels[word[0]] {
            result[i] = word + "ma"
        } else {
            result[i] = word[1:] + string(word[0]) + "ma"
        }
        for j := 0; j <= i; j++ {
            result[i] += "a"
        }
    }

    return strings.Join(result, " ")
}