import "math"

func minEatingSpeed(piles []int, h int) int {
	maxPile := 0
	for _, pile := range piles {
		if pile > maxPile {
			maxPile = pile
		}
	}

	left := 1
	right := maxPile
	ans := maxPile