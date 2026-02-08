var spellchecker = function(wordlist, queries) {
    const exactSet = new Set();
    const lowerMap = new Map();
    const vowelMap = new Map();

    const replaceVowels = (s) => {
        let res = [];
        const vowels = new Set(['a', 'e', 'i', 'o', 'u']);
        for (let char of s) {
            if (vowels.has(char)) {
                res.push('*');
            } else {
                res.push(char);
            }
        }
        return res.join('');
    };

    for (const word of wordlist) {
        exactSet.add(word);

        const lowerWord = word.toLowerCase();
        if (!lowerMap.has(lowerWord)) {
            lowerMap.set(lowerWord, word);
        }

        const vowelWord = replaceVowels(lowerWord);
        if (!vowelMap.has(vowelWord)) {
            vowelMap.set(vowelWord, word);
        }
    }

    const result = [];
    for (const query of queries) {
        if (exactSet.has(query)) {
            result.push(query);
            continue;
        }

        const lowerQuery = query.toLowerCase();
        if (lowerMap.has(lowerQuery)) {
            result.push(lowerMap.get(lowerQuery));
            continue;
        }

        const vowelQuery = replaceVowels(lowerQuery);
        if (vowelMap.has(vowelQuery)) {
            result.push(vowelMap.get(vowelQuery));
            continue;
        }

        result.push("");
    }

    return result;
};