import "strings"

func fullJustify(words []string, maxWidth int) []string {
	var res []string
	var cur []string
	var curLen int

	for _, word := range words {
		if curLen+len(word)+len(cur) > maxWidth {
			if len(cur) == 1 {
				res = append(res, cur[0]+strings.Repeat(" ", maxWidth-curLen))
			} else {
				spaces := maxWidth - curLen
				spaceEach := spaces / (len(cur) - 1)
				extraSpaces := spaces % (len(cur) - 1)
				line := ""
				for i := 0; i < len(cur)-1; i++ {
					line += cur[i] + strings.Repeat(" ", spaceEach)
					if i < extraSpaces {
						line += " "
					}
				}
				line += cur[len(cur)-1]
				res = append(res, line)
			}
			cur = []string{}
			curLen = 0
		}
		cur = append(cur, word)
		curLen += len(word)
	}

	lastLine := strings.Join(cur, " ")
	lastLine += strings.Repeat(" ", maxWidth-len(lastLine))
	res = append(res, lastLine)

	return res
}