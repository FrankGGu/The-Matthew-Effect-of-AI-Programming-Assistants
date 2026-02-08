import "fmt"

func melt(df map[string][]any, idVars []string, valueVars []string) map[string][]any {
	var idCols []string
	var valueCols []string

	for _, col := range idVars {
		idCols = append(idCols, col)
	}
	for _, col := range valueVars {
		valueCols = append(valueCols, col)
	}

	numRows := len(df[idCols[0]])

	idVals := make([]any, 0)
	variableVals := make([]string, 0)
	valueVals := make([]any, 0)

	for i := 0; i < numRows; i++ {
		for _, valueCol := range valueCols {
			idRow := make([]any, 0)
			for _, idCol := range idCols {
				idRow = append(idRow, df[idCol][i])
			}

			idVals = append(idVals, idRow...)
			variableVals = append(variableVals, valueCol)
			valueVals = append(valueVals, df[valueCol][i])
		}
	}

	result := make(map[string][]any)
	result["id"] = idVals
	result["variable"] = variableVals
	result["value"] = valueVals

	return result
}