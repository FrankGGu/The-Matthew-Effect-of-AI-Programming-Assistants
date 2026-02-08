func maxProduct(s string) int {
	n := len(s)
	maxProd := 0
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			digit1 := int(s[i] - '0')
			digit2 := int(s[j] - '0')
			prod := digit1 * digit2
			if prod > maxProd {
				maxProd = prod
			}
		}
	}
	return maxProd
}