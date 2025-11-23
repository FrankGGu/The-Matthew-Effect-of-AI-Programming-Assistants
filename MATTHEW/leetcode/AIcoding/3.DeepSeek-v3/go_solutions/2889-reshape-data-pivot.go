func pivotTable(df DataFrame, rows []string, columns string, values string) DataFrame {
    // Group by the rows and columns, then aggregate the values
    grouped := df.GroupBy(append(rows, columns)...).Agg(Sum(values))

    // Pivot the table
    pivoted := grouped.Pivot(columns, values)

    return pivoted
}