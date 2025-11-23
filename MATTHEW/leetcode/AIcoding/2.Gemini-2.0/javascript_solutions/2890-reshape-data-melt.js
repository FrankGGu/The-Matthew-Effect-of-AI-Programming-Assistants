var melt = function(content) {
    const result = [];
    for (const row of content) {
        const id = row.id;
        for (const key in row) {
            if (key !== 'id') {
                result.push({ id: id, variable: key, value: row[key] });
            }
        }
    }
    return result;
};