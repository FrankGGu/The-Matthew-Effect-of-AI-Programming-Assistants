type DataFrame struct {
    data [][]string
    columns []string
}

func CreateDataFrame(data [][]string, columns []string) DataFrame {
    return DataFrame{
        data: data,
        columns: columns,
    }
}

/**
 * Your DataFrame methods will be instantiated and called as such:
 * obj := CreateDataFrame(data, columns);
 * param_1 := obj.GetCell(row,column);
 * param_2 := obj.GetRow(row);
 * param_3 := obj.GetColumn(column);
 */