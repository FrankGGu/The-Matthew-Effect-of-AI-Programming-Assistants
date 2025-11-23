import (
	"sort"
)

func supplyWagon(supplies []int) []int {
	n := len(supplies)
	for n > len(supplies)/2 {
		minSum := supplies[0] + supplies[1]
		minIndex := 0
		for i := 1; i < len(supplies)-1; i++ {
			currentSum := supplies[i] + supplies[i+1]
			if currentSum < minSum {
				minSum = currentSum
				minIndex = i
			}
		}
		supplies[minIndex] = minSum
		supplies = append(supplies[:minIndex+1], supplies[minIndex+2:]...)
		n--
	}
	sort.Ints(supplies)
	return supplies
}