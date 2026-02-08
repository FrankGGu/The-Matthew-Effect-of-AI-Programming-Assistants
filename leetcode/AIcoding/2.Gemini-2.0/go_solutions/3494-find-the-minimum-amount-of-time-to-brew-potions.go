import (
	"sort"
)

func minPotionTime(potions []int, success int64, strength int) int {
	sort.Ints(potions)
	n := len(potions)
	ans := 0
	for _, p := range potions {
		neededStrength := (success + int64(p) - 1) / int64(p)
		if neededStrength > int64(strength) {
			ans++
		}
	}
	return ans
}