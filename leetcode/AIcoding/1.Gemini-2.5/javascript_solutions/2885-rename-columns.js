var renameColumns = function(rows) {
    return rows.map(row => {
        const newRow = {};
        for (const key in row) {
            if (Object.prototype.hasOwnProperty.call(row, key)) {
                if (key === 'id') {
                    newRow['userId'] = row[key];
                } else if (key === 'name') {
                    newRow['userName'] = row[key];
                } else {
                    newRow[key] = row[key];
                }
            }
        }
        return newRow;
    });
};