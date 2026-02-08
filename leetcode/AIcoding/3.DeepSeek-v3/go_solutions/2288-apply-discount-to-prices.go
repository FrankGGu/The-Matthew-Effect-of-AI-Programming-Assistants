import (
	"strconv"
	"strings"
)

func discountPrices(sentence string, discount int) string {
	words := strings.Fields(sentence)
	for i, word := range words {
		if len(word) > 1 && word[0] == '$' {
			numStr := word[1:]
			if num, err := strconv.ParseFloat(numStr, 64); err == nil {
				discounted := num * (100.0 - float64(discount)) / 100.0
				words[i] = "$" + strconv.FormatFloat(discounted, 'f', 2, 64)
			}
		}
	}
	return strings.Join(words, " ")
}