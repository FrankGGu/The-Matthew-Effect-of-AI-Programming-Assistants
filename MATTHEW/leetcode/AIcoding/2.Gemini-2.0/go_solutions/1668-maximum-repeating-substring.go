import "strings"

func maxRepeating(sequence string, word string) int {
	res := 0
	temp := word
	for strings.Contains(sequence, temp) {
		res++
		temp += word
	}
	return res
}