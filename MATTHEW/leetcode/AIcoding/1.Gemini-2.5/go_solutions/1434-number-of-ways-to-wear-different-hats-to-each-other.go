func numberWays(hats [][]int) int {
	n := len(hats)
	MOD := 1_000_000_007

	maxHatID := 0
	for _, personHats := range hats {