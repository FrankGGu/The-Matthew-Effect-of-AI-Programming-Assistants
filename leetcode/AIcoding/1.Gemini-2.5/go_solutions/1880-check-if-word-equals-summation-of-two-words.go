func isSumEqual(firstWord string, secondWord string, targetWord string) bool {

    wordToValue := func(word string) int {
        value := 0
        for _, char := range word {
            value = value*10 + int(char - 'a')
        }
        return value
    }

    return wordToValue(firstWord) + wordToValue(secondWord) == wordToValue(targetWord)
}