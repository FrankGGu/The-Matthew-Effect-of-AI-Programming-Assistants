func isSumEqual(firstWord string, secondWord string, targetWord string) bool {
    convert := func(word string) int {
        res := 0
        for _, ch := range word {
            res = res * 10 + int(ch - 'a')
        }
        return res
    }
    return convert(firstWord) + convert(secondWord) == convert(targetWord)
}