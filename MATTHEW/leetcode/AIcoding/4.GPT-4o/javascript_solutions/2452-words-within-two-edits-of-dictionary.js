var twoEditWords = function(queries, dictionary) {
    const isValid = (word1, word2) => {
        let diff = 0;
        for (let i = 0; i < word1.length; i++) {
            if (word1[i] !== word2[i]) {
                diff++;
                if (diff > 2) return false;
            }
        }
        return true;
    };

    return queries.map(query => 
        dictionary.filter(dictWord => isValid(query, dictWord))
    );
};