var spellchecker = function(wordlist, queries) {
    const exactSet = new Set(wordlist);
    const vowelMap = new Map();
    const vowels = 'aeiou';

    for (const word of wordlist) {
        const lowWord = word.toLowerCase();
        if (!vowelMap.has(lowWord)) {
            vowelMap.set(lowWord, word);
        }
    }

    const replaceVowels = (word) => {
        return word.replace(/[aeiou]/g, '*');
    };

    const vowelSet = new Map();
    for (const word of wordlist) {
        const key = replaceVowels(word.toLowerCase());
        if (!vowelSet.has(key)) {
            vowelSet.set(key, word);
        }
    }

    return queries.map(query => {
        if (exactSet.has(query)) {
            return query;
        }
        const lowQuery = query.toLowerCase();
        if (vowelMap.has(lowQuery)) {
            return vowelMap.get(lowQuery);
        }
        const vowelKey = replaceVowels(lowQuery);
        return vowelSet.has(vowelKey) ? vowelSet.get(vowelKey) : '';
    });
};