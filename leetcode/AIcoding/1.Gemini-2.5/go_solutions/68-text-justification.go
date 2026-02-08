func fullJustify(words []string, maxWidth int) []string {
	result := []string{}
	n := len(words)
	i := 0 // current word index

	for i < n {
		currentLineWords := []string{}
		currentLineWordsLength := 0 // sum