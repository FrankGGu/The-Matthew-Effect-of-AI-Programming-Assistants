func uniqueMorseRepresentations(words []string) int {
    morseCodes := []string{".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."}

    transformations := make(map[string]bool)

    for _, word := range words {
        var transformation strings.Builder
        for _, c := range word {
            transformation.WriteString(morseCodes[c - 'a'])
        }
        transformations[transformation.String()] = true
    }

    return len(transformations)
}