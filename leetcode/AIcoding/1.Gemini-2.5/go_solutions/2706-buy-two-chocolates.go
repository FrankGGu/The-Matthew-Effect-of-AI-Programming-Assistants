import "math"

func buyChoco(prices []int, money int) int {
	min1 := math.MaxInt
	min2 := math.MaxInt

	for _, price := range prices {
		if price < min1 {
			min2 = min1
			min1 = price
		} else if price < min2 {
			min2 = price
		}
	}

	totalCost := min1 + min2

	if totalCost <= money {
		return money - totalCost
	}
	return money
}