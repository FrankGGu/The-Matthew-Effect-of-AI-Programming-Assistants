type Spreadsheet struct {
	cells map[string]string
}

func Constructor(rows int, cols int) Spreadsheet {
	return Spreadsheet{cells: make(map[string]string)}
}

func (this *Spreadsheet) Set(row int, col int, contents string) {
	key := fmt.Sprintf("%c%d", 'A'+col-1, row)
	this.cells[key] = contents
}

func (this *Spreadsheet) Get(row int, col int) string {
	key := fmt.Sprintf("%c%d", 'A'+col-1, row)
	return this.evaluate(key)
}

func (this *Spreadsheet) evaluate(cell string) string {
	content, ok := this.cells[cell]
	if !ok {
		return "0"
	}

	if !strings.HasPrefix(content, "=") {
		return content
	}

	expression := content[1:]
	tokens := strings.Split(expression, "+")
	sum := 0
	for _, token := range tokens {
		token = strings.TrimSpace(token)
		if unicode.IsLetter(rune(token[0])) {
			val, _ := strconv.Atoi(this.evaluate(token))
			sum += val
		} else {
			val, _ := strconv.Atoi(token)
			sum += val
		}
	}
	return strconv.Itoa(sum)
}

import (
	"fmt"
	"strconv"
	"strings"
	"unicode"
)