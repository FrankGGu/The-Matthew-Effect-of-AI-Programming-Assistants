var twoEditWords = function(queries, dictionary) {
    const result = [];

    for (const queryWord of queries) {
        let foundMatch = false;
        for (const dictWord of dictionary) {
            let diffCount = 0;
            const len = queryWord.length;

            for (let i = 0; i < len; i++) {
                if (queryWord[i] !== dictWord[i]) {
                    diffCount++;
                }
                if (diffCount > 2) {
                    break;
                }
            }

            if (diffCount <= 2) {
                result.push(queryWord);
                foundMatch = true;
                break;
            }
        }
    }

    return result;
};