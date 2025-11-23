var distinctNames = function(ideas) {
    const charToSuffixes = new Map();

    for (const idea of ideas) {
        const firstChar = idea[0];
        const suffix = idea.substring(1);
        if (!charToSuffixes.has(firstChar)) {
            charToSuffixes.set(firstChar, new Set());
        }
        charToSuffixes.get(firstChar).add(suffix);
    }

    let count = 0;

    for (let i = 0; i < 26; i++) {
        for (let j = i + 1; j < 26; j++) {
            const char1 = String.fromCharCode('a'.charCodeAt(0) + i);
            const char2 = String.fromCharCode('a'.charCodeAt(0) + j);

            const suffixes1 = charToSuffixes.get(char1);
            const suffixes2 = charToSuffixes.get(char2);

            if (!suffixes1 || !suffixes2) {
                continue;
            }

            let uniqueSuffixes1 = 0;
            for (const s of suffixes1) {
                if (!suffixes2.has(s)) {
                    uniqueSuffixes1++;
                }
            }

            let uniqueSuffixes2 = 0;
            for (const s of suffixes2) {
                if (!suffixes1.has(s)) {
                    uniqueSuffixes2++;
                }
            }

            count += uniqueSuffixes1 * uniqueSuffixes2;
        }
    }

    return count * 2;
};