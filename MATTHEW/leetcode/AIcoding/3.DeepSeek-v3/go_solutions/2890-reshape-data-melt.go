func meltData(df *DataFrame, idVars []string, valueVars []string, varName string, valueName string) *DataFrame {
    var meltedRows []Row
    for _, row := range df.Rows {
        idValues := make(map[string]interface{})
        for _, idVar := range idVars {
            idValues[idVar] = row[idVar]
        }

        for _, valueVar := range valueVars {
            newRow := make(Row)
            for k, v := range idValues {
                newRow[k] = v
            }
            newRow[varName] = valueVar
            newRow[valueName] = row[valueVar]
            meltedRows = append(meltedRows, newRow)
        }
    }

    var columns []string
    columns = append(columns, idVars...)
    columns = append(columns, varName, valueName)

    return &DataFrame{
        Columns: columns,
        Rows:    meltedRows,
    }
}