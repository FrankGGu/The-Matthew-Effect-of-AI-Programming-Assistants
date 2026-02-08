func shoppingOffers(price []int, special [][]int, needs []int) int {
	n := len(price)
	memo := make(map[[6]int]int)

	// Helper function to find the minimum of two integers
	min := func(a, b int) int