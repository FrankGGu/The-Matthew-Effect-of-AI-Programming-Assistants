import "fmt"

type Node struct {
	maxLen     int    // Maximum length of a repeating character substring in this segment.
	prefixLen  int    // Length of the repeating character substring at the beginning of this segment.
	suffixLen  int    // Length of the repeating character substring