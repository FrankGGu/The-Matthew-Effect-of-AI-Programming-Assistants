import "strings"

func findTheLongestSubstring(s string) int {
    maxLen := 0
    currState := 0 // Bitmask for vowel counts: a=0, e=1, i=2, o=3, u=4

    // firstOccurrence stores the first index where a particular state was encountered.