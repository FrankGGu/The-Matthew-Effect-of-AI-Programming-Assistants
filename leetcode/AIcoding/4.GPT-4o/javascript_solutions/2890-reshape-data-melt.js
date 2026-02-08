function melt(data) {
    const result = [];
    for (const row of data) {
        for (const [key, value] of Object.entries(row)) {
            if (key !== 'id') {
                result.push({ id: row.id, metric: key, value: value });
            }
        }
    }
    return result;
}