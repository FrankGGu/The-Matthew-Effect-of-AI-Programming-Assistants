import (
	"sort"
)

type DataFrame struct {
	Columns []string
	Data    [][]any
}

func modifyColumns(df DataFrame) DataFrame {
	newCols := make([]string, len(df.Columns))
	for i, col := range df.Columns {
		newCols[i] = "modified_" + col
	}

	return DataFrame{
		Columns: newCols,
		Data:    df.Data,
	}
}

func selectData(df DataFrame, rows []int) DataFrame {
	newData := make([][]any, 0)
	for _, row := range rows {
		if row >= 0 && row < len(df.Data) {
			newData = append(newData, df.Data[row])
		}
	}

	return DataFrame{
		Columns: df.Columns,
		Data:    newData,
	}
}

func createBonusColumn(df DataFrame, calc func(row []any) any) DataFrame {
	newCols := append(df.Columns, "bonus")
	newData := make([][]any, len(df.Data))
	for i := range df.Data {
		newData[i] = append(df.Data[i], calc(df.Data[i]))
	}

	return DataFrame{
		Columns: newCols,
		Data:    newData,
	}
}

func dropDuplicateRows(df DataFrame) DataFrame {
	seen := make(map[string]bool)
	newData := make([][]any, 0)

	for _, row := range df.Data {
		rowStr := ""
		for _, val := range row {
			rowStr += toString(val) + ","
		}

		if !seen[rowStr] {
			seen[rowStr] = true
			newData = append(newData, row)
		}
	}

	return DataFrame{
		Columns: df.Columns,
		Data:    newData,
	}
}

func joinDataFrames(df1 DataFrame, df2 DataFrame, joinColumn string) DataFrame {
	colIndex1 := -1
	for i, col := range df1.Columns {
		if col == joinColumn {
			colIndex1 = i
			break
		}
	}

	colIndex2 := -1
	for i, col := range df2.Columns {
		if col == joinColumn {
			colIndex2 = i
			break
		}
	}

	if colIndex1 == -1 || colIndex2 == -1 {
		return DataFrame{}
	}

	joinedData := make([][]any, 0)
	joinedColumns := append(df1.Columns, df2.Columns...)
	joinedColumns = removeDuplicateStrings(joinedColumns)

	for _, row1 := range df1.Data {
		joinValue1 := row1[colIndex1]

		for _, row2 := range df2.Data {
			joinValue2 := row2[colIndex2]

			if toString(joinValue1) == toString(joinValue2) {
				newRow := make([]any, 0)
				newRow = append(newRow, row1...)

				for i, val := range row2 {
					found := false
					for _, col := range df1.Columns {
						if df2.Columns[i] == col {
							found = true
							break
						}
					}
					if !found {
						newRow = append(newRow, val)
					}
				}
				joinedData = append(joinedData, newRow)

			}
		}
	}

	return DataFrame{
		Columns: joinedColumns,
		Data:    joinedData,
	}
}

func removeDuplicateStrings(s []string) []string {
	seen := make(map[string]bool)
	result := []string{}

	for _, str := range s {
		if !seen[str] {
			result = append(result, str)
			seen[str] = true
		}
	}
	return result
}

func toString(val any) string {
	switch v := val.(type) {
	case int:
		return string(rune(v))
	case string:
		return v
	case float64:
		return string(rune(int(v)))
	case bool:
		if v {
			return "true"
		}
		return "false"
	default:
		return ""
	}
}

func sortDataframe(df DataFrame, column string, ascending bool) DataFrame {
	columnIndex := -1
	for i, col := range df.Columns {
		if col == column {
			columnIndex = i
			break
		}
	}

	if columnIndex == -1 {
		return df
	}

	sort.Slice(df.Data, func(i, j int) bool {
		val1 := df.Data[i][columnIndex]
		val2 := df.Data[j][columnIndex]

		str1 := toString(val1)
		str2 := toString(val2)

		if ascending {
			return str1 < str2
		} else {
			return str1 > str2
		}
	})

	return df
}