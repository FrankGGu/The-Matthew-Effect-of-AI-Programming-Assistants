type charCount struct {
	char  rune
	count int
}

func removeDuplicates(s string, k int) string {
	stack := []charCount{}

	for _, c := range s {
		if len(stack) > 0 && stack[len(