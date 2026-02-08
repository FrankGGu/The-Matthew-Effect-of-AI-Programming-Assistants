var twoEditWords = function(queries, dictionary) {
    const result = [];
    for (const query of queries) {
        let found = false;
        for (const word of dictionary) {
            if (query.length !== word.length) continue;
            let diff = 0;
            for (let i = 0; i < query.length; i++) {
                if (query[i] !== word[i]) {
                    diff++;
                    if (diff > 2) break;
                }
            }
            if (diff <= 2) {
                found = true;
                break;
            }
        }
        if (found) {
            result.push(query);
        }
    }
    return result;
};