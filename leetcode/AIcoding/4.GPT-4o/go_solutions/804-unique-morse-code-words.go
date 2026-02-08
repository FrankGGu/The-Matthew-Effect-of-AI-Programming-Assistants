func uniqueMorseRepresentations(words []string) int {
    morseCode := []string{".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", "..", ".---", "-.-", ".-..", "--", "-.", "---", ".--.", "--.-", ".-.", "...", "-", "..-", "...-", ".--", "-..-", "-.--", "--.."}
    morseSet := make(map[string]struct{})

    for _, word := range words {
        var morseWord strings.Builder
        for _, ch := range word {
            morseWord.WriteString(morseCode[ch-'a'])
        }
        morseSet[morseWord.String()] = struct{}{}
    }

    return len(morseSet)
}