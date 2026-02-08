func spellchecker(wordlist []string, queries []string) []string {
	exactSet := make(map[string]bool)
	caseInsensitiveMap := make(map[string]string)
	vowelErrorMap := make(map[string]string)

	for _, word