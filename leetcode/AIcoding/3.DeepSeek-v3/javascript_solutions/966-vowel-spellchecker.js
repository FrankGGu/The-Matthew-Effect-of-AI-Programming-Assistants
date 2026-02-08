var spellchecker = function(wordlist, queries) {
    const exactMatch = new Set(wordlist);
    const caseInsensitive = new Map();
    const vowelInsensitive = new Map();
    const vowels = new Set(['a', 'e', 'i', 'o', 'u']);

    for (const word of wordlist) {
        const lower = word.toLowerCase();
        if (!caseInsensitive.has(lower)) {
            caseInsensitive.set(lower, word);
        }

        const devowel = lower.replace(/[aeiou]/g, '*');
        if (!vowelInsensitive.has(devowel)) {
            vowelInsensitive.set(devowel, word);
        }
    }

    const result = [];
    for (const query of queries) {
        if (exactMatch.has(query)) {
            result.push(query);
            continue;
        }

        const lower = query.toLowerCase();
        if (caseInsensitive.has(lower)) {
            result.push(caseInsensitive.get(lower));
            continue;
        }

        const devowel = lower.replace(/[aeiou]/g, '*');
        if (vowelInsensitive.has(devowel)) {
            result.push(vowelInsensitive.get(devowel));
            continue;
        }

        result.push("");
    }

    return result;
};