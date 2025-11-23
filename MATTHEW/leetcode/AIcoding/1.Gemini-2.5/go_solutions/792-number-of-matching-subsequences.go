func numMatchingSubsequences(s string, words []string) int {
	// `waitingLists` is an array of 26 slices. Each slice corresponds to a letter 'a' through 'z'.
	// It stores `wordItem`s, where each `wordItem` represents a word from `words`
	// that is currently