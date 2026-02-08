func Melt(data [][]string, idVars []string, valueVars []string) [][]string {
	if len(data) == 0 {
		return [][]string{}
	}

	header := data[0]
	colToIndex := make(map[string]int)
	for i, colName := range header {