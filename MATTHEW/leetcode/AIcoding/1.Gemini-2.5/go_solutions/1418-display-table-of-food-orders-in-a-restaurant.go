func displayTable(orders [][]string) [][]string {
	foodItemsSet := make(map[string]struct{})
	tableNumbersSet := make(map[int]struct{})
	tableFoodCounts := make(map[int]map[string]int)