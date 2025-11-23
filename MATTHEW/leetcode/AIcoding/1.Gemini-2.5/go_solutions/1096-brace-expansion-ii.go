func braceExpansionII(expression string) []string {
	idx := 0
	resultMap := parseItem(expression, &idx)

	resultList := make([]string, 0, len(resultMap))
	for s := range resultMap {
		result