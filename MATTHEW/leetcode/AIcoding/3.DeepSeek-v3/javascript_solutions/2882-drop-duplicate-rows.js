var dropDuplicateRows = function(dataframe) {
    const seen = new Set();
    const result = [];
    for (const row of dataframe) {
        const key = JSON.stringify(row);
        if (!seen.has(key)) {
            seen.add(key);
            result.push(row);
        }
    }
    return result;
};