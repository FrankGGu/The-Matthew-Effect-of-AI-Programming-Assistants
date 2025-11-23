package main

import (
	"fmt"
	"regexp"
	"strconv"
	"strings"
)

func discountPrices(sentence string, discount int) string {
	re := regexp.MustCompile(`\$[0-9]+`)
	words := strings.Fields(sentence)
	for i, word := range words {
		if re.MatchString(word) {
			priceStr := word[1:]
			price, _ := strconv.Atoi(priceStr)
			discountedPrice := price - price*discount/100
			words[i] = fmt.Sprintf("$%d", discountedPrice)
		}
	}
	return strings.Join(words, " ")
}

func main() {
	sentence := "There are $100 dollars in the bank"
	discount := 20
	fmt.Println(discountPrices(sentence, discount))
}