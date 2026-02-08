var camelMatch = function(queries, pattern) {
    const isMatch = (query) => {
        let j = 0;
        for (let i = 0; i < query.length; i++) {
            if (j < pattern.length && query[i] === pattern[j]) {
                j++;
            } else if (query[i] === query[i].toUpperCase()) {
                return false;
            }
        }
        return j === pattern.length;
    };

    return queries.map(isMatch);
};