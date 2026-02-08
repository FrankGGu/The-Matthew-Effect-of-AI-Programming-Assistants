type DataFrame struct {
	ColumnNames []string
	Data        [][]interface{}
}

func CreateDataFrame(columnNames []string, data [][]interface{}) DataFrame {
	return DataFrame{
		ColumnNames: columnNames,
		Data:        data,
	}
}