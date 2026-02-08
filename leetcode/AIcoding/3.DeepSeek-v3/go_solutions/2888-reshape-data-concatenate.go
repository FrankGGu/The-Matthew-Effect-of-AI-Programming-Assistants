func concatenateTables(df1 []map[string]interface{}, df2 []map[string]interface{}) []map[string]interface{} {
    return append(df1, df2...)
}