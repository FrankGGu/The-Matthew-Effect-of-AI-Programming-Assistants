import "strings"

func convert(s string, numRows int) string {
	if numRows == 1 {
		return s
	}

	// Create numRows slices of bytes, each representing a row.
	// Using [][]byte and then a strings.Builder is generally efficient
	// in Go for building strings piece