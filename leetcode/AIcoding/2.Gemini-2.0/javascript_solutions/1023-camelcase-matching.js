var camelMatch = function(queries, pattern) {
    const res = [];
    for (const query of queries) {
        let pIdx = 0;
        let match = true;
        for (const char of query) {
            if (pIdx < pattern.length && char === pattern[pIdx]) {
                pIdx++;
            } else if (char >= 'A' && char <= 'Z') {
                match = false;
                break;
            }
        }
        if (pIdx !== pattern.length) {
            match = false;
        }
        res.push(match);
    }
    return res;
};