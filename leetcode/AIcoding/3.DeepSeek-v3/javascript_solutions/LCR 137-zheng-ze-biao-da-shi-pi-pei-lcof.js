var camelMatch = function(query, pattern) {
    let patternIndex = 0;
    for (let i = 0; i < query.length; i++) {
        if (patternIndex < pattern.length && query[i] === pattern[patternIndex]) {
            patternIndex++;
        } else if (query[i] === query[i].toUpperCase()) {
            return false;
        }
    }
    return patternIndex === pattern.length;
};