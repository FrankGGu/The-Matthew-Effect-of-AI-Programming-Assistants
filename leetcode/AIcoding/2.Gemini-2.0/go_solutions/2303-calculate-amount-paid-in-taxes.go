func calculateTax(brackets [][]int, income int) float64 {
	tax := 0.0
	prev := 0
	for _, bracket := range brackets {
		upper := bracket[0]
		percent := float64(bracket[1]) / 100.0
		taxable := upper - prev
		if income >= taxable {
			tax += float64(taxable) * percent
			income -= taxable
		} else {
			tax += float64(income) * percent
			break
		}
		prev = upper
	}
	return tax
}