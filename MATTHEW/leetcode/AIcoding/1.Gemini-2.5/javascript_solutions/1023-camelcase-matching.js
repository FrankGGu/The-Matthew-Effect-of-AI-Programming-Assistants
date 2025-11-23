var camelMatch = function(queries, pattern) {
    const result = [];

    const isMatch = (query, pattern) => {
        let pIdx = 0; // Pointer for pattern

        for (let qIdx = 0; qIdx < query.length; qIdx++) {
            if (pIdx < pattern.length && query[qIdx] === pattern[pIdx]) {
                pIdx++; // Matched a character from pattern
            } else if (query[qIdx] === query[qIdx].toUpperCase()) {
                // query[qIdx] is an uppercase letter.
                // If it didn't match pattern[pIdx] (either pIdx is out of bounds
                // or characters don't match), it's an extra uppercase letter in query,
                // which is not allowed.
                return false;
            }
            // If query[qIdx] is a lowercase letter and didn't match pattern[pIdx],
            // it's an extra lowercase letter in query, which is allowed.
            // We simply continue to the next character in query.
        }

        // After iterating through the query, check if all characters in the pattern were matched.
        return pIdx === pattern.length;
    };

    for (const query of queries) {
        result.push(isMatch(query, pattern));
    }

    return result;
};