func isSumEqual(firstWord string, secondWord string, targetWord string) bool {
    wordToNum := func(word string) int {
        num := 0
        for i := 0; i < len(word); i++ {
            num = num*10 + int(word[i]-'a')
        }
        return num
    }

    return wordToNum(firstWord)+wordToNum(secondWord) == wordToNum(targetWord)
}