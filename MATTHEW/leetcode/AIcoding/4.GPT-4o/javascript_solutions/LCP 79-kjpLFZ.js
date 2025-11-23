var spellChecker = function(wordlist, queries) {
    const exactSet = new Set(wordlist);
    const lowerSet = new Set();
    const vowelSet = new Set(['a', 'e', 'i', 'o', 'u']);
    const vowelMap = new Map();

    for (let word of wordlist) {
        const lowerWord = word.toLowerCase();
        lowerSet.add(lowerWord);
        if (!vowelMap.has(lowerWord)) {
            vowelMap.set(lowerWord, word);
        }
    }

    const replaceVowels = (word) => {
        let chars = word.split('');
        for (let i = 0; i < chars.length; i++) {
            if (vowelSet.has(chars[i])) {
                chars[i] = '*';
            }
        }
        return chars.join('');
    };

    const vowelMapWithWildcard = new Map();
    for (let word of wordlist) {
        const replaced = replaceVowels(word.toLowerCase());
        if (!vowelMapWithWildcard.has(replaced)) {
            vowelMapWithWildcard.set(replaced, word);
        }
    }

    return queries.map(query => {
        if (exactSet.has(query)) {
            return query;
        }
        const lowerQuery = query.toLowerCase();
        if (lowerSet.has(lowerQuery)) {
            return vowelMap.get(lowerQuery);
        }
        const replacedQuery = replaceVowels(lowerQuery);
        return vowelMapWithWildcard.get(replacedQuery) || '';
    });
};