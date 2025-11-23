var spellchecker = function(wordlist, queries) {
    const exactMap = new Set(wordlist);
    const caseMap = new Map();
    const vowelMap = new Map();

    for (const word of wordlist) {
        const lower = word.toLowerCase();
        if (!caseMap.has(lower)) {
            caseMap.set(lower, word);
        }

        const vowelReplaced = lower.replace(/[aeiou]/g, '#');
        if (!vowelMap.has(vowelReplaced)) {
            vowelMap.set(vowelReplaced, word);
        }
    }

    const result = [];
    for (const query of queries) {
        if (exactMap.has(query)) {
            result.push(query);
        } else {
            const lower = query.toLowerCase();
            if (caseMap.has(lower)) {
                result.push(caseMap.get(lower));
            } else {
                const vowelReplaced = lower.replace(/[aeiou]/g, '#');
                if (vowelMap.has(vowelReplaced)) {
                    result.push(vowelMap.get(vowelReplaced));
                } else {
                    result.push("");
                }
            }
        }
    }

    return result;
};