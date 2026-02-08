import (
	"fmt"
	"strconv"
	"strings"
)

func discountPrices(sentence string, discount int) string {
	words := strings.Split(sentence, " ")
	for i := range words {
		if strings.HasPrefix(words[i], "$") && len(words[i]) > 1 {
			priceStr := words[i][1:]
			price, err := strconv.Atoi(priceStr)
			if err == nil {
				discountedPrice := float64(price) * (1 - float64(discount)/100)
				words[i] = fmt.Sprintf("$%.2f", discountedPrice)
			}
		}
	}
	return strings.Join(words, " ")
}