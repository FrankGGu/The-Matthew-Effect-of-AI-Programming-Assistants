func discountPrices(sentence string, discount int) string {
	words := strings.Fields(sentence)
	resultWords := make([]string, len(words))
	discountFactor := 1.0 - float64(