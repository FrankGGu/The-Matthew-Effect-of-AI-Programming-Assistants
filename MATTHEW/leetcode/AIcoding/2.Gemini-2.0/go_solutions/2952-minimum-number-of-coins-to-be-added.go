import "sort"

func minPatches(coins []int, amount int) int {
	sort.Ints(coins)
	patches := 0
	reachable := 0
	coinIndex := 0
	for reachable < amount {
		if coinIndex < len(coins) && coins[coinIndex] <= reachable+1 {
			reachable += coins[coinIndex]
			coinIndex++
		} else {
			patches++
			reachable += reachable + 1
		}
	}
	return patches
}