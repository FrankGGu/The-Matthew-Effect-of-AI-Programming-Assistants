package main

func concatenateTables(df1 [][]string, df2 [][]string) [][]string {
    result := make([][]string, len(df1)+len(df2))
    for i := range df1 {
        result[i] = df1[i]
    }
    for i := range df2 {
        result[len(df1)+i] = df2[i]
    }
    return result
}