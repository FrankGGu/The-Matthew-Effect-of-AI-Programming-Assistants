import (
	"strconv"
	"strings"
)

func dropDuplicateRows(rows [][]int) [][]int {
	seen := make(map[string]bool)
	var result [][]int

	for _, row := range rows {
		var sb strings.Builder
		for i, val := range row {
			sb.WriteString(strconv.Itoa(val))
			if i < len(row)-1 {
				sb.WriteString(",")
			}
		}
		rowStr := sb.String()

		if !seen[rowStr] {
			seen[rowStr] = true
			result = append(result, row)
		}
	}
	return result
}