func shoppingOffers(price []int, special [][]int, needs []int) int {
	n := len(price)
	minPrice := dotProduct(price, needs)

	for _, offer := range special {
		tempNeeds := make([]int, n)
		copy(tempNeeds, needs)
		valid := true
		for i := 0; i < n; i++ {
			tempNeeds[i] -= offer[i]
			if tempNeeds[i] < 0 {
				valid = false
				break
			}
		}
		if valid {
			newPrice := shoppingOffers(price, special, tempNeeds) + offer[n]
			if newPrice < minPrice {
				minPrice = newPrice
			}
		}
	}

	return minPrice
}

func dotProduct(price []int, needs []int) int {
	sum := 0
	for i := 0; i < len(price); i++ {
		sum += price[i] * needs[i]
	}
	return sum
}