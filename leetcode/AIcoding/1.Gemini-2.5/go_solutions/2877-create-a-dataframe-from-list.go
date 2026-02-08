type DataFrame struct {
    Columns []string
    Data    [][]string
}

func createDataFrame(list [][]string) DataFrame {
    if len(list) == 0 {
        return DataFrame{}
    }

    columns := list[0]
    data := [][]string{}

    if len(list) > 1 {
        data = list[1:]
    }

    return DataFrame{
        Columns: columns,
        Data:    data,
    }
}