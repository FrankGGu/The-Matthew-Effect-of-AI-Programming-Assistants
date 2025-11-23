import "strings"

func antiqueKeyboard(s string) string {
	var result strings.Builder
	flipCase := false

	for _, r := range s {
		if r == '*' {
			flipCase = !flipCase
		} else {
			if flipCase {
				if r >= 'a' && r <= 'z'