var pivotTable = function (table) {
    const result = {};
    const headers = Object.keys(table[0]);

    for (const row of table) {
        const key = row[headers[0]];
        if (!result[key]) {
            result[key] = {};
        }
        for (let i = 1; i < headers.length; i++) {
            const colName = headers[i];
            result[key][colName] = row[colName];
        }
    }

    return Object.values(result).map(item => ({ ...item }));
};