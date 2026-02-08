func countMatches(items [][]string, ruleKey string, ruleValue string) int {
	count := 0
	ruleIndex := -1

	if ruleKey == "type" {
		ruleIndex = 0
	} else if ruleKey == "color" {
		ruleIndex = 1
	} else if ruleKey == "name" {
		ruleIndex = 2
	}

	for _, item := range items {
		if item[ruleIndex] == ruleValue {
			count++
		}
	}

	return count
}