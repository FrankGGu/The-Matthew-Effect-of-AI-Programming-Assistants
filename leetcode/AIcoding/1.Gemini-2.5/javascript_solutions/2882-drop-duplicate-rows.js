function dropDuplicateRows(rows) {
    const seenRows = new Set();
    const uniqueRows = [];

    for (const row of rows) {
        const rowString = JSON.stringify(row);
        if (!seenRows.has(rowString)) {
            seenRows.add(rowString);
            uniqueRows.push(row);
        }
    }

    return uniqueRows;
}