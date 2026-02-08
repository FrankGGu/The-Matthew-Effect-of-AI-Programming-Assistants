import "sort"

func maximizeAmount(amounts []int, conversions int) int {
	sort.Ints(amounts)
	n := len(amounts)
	for i := 0; i < conversions; i++ {
		amounts[i] = -amounts[i]
	}
	sum := 0
	for _, amount := range amounts {
		sum += amount
	}
	return sum
}