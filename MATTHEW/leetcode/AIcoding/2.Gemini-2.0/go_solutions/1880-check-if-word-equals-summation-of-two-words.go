func isSumEqual(firstWord string, secondWord string, targetWord string) bool {
	return wordValue(firstWord)+wordValue(secondWord) == wordValue(targetWord)
}

func wordValue(s string) int {
	res := 0
	for _, c := range s {
		res = res*10 + int(c-'a')
	}
	return res
}