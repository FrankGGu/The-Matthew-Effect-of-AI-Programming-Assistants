func createNewColumn(df DataFrame) DataFrame {
    df["new_column"] = make([]int, len(df["A"]))
    for i := range df["A"] {
        df["new_column"][i] = df["A"][i] + 1
    }
    return df
}