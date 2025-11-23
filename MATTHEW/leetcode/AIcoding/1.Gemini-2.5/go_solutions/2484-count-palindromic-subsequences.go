import "strings"

func countPalindromicSubsequences(s string) int {
	n := len(s)

	firstOccurrence := [26]int{}
	lastOccurrence := [26]int{}

	for i := 0; i < 26; i++ {
		firstOccurrence[