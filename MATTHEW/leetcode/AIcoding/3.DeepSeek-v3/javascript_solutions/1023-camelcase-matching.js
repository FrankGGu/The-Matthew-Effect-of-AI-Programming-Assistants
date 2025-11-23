var camelMatch = function(queries, pattern) {
    const result = [];
    for (const query of queries) {
        let i = 0;
        let match = true;
        for (const c of query) {
            if (i < pattern.length && c === pattern[i]) {
                i++;
            } else if (c === c.toUpperCase()) {
                match = false;
                break;
            }
        }
        result.push(match && i === pattern.length);
    }
    return result;
};