function camelMatch(queries, pattern) {
    const result = [];
    for (const query of queries) {
        let i = 0;
        let j = 0;
        let match = true;
        while (i < query.length) {
            if (j < pattern.length && query[i] === pattern[j]) {
                i++;
                j++;
            } else if (query[i] >= 'A' && query[i] <= 'Z') {
                match = false;
                break;
            } else {
                i++;
            }
        }
        if (j < pattern.length) {
            match = false;
        }
        result.push(match);
    }
    return result;
}