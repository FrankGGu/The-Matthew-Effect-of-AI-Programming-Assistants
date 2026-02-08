var renameColumns = function(df, names) {
    const newColumns = df.columns.map(col => names[col] !== undefined ? names[col] : col);
    const newData = df.data.map(row => {
        const newRow = {};
        for (const col in row) {
            const newCol = names[col] !== undefined ? names[col] : col;
            newRow[newCol] = row[col];
        }
        return newRow;
    });
    return new DataFrame(newColumns, newData);
};