var renameColumns = function(df, colMap) {
    const newColumns = df.columns.map(col => colMap[col] || col);
    df.columns = newColumns;
    return df;
};