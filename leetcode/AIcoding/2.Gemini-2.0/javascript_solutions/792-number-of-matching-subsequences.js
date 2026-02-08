var numMatchingSubsequences = function(s, words) {
    let count = 0;
    const map = new Map();

    for (const word of words) {
        if (map.has(word)) {
            count += map.get(word);
            continue;
        }

        let sIndex = 0;
        let wordIndex = 0;

        while (sIndex < s.length && wordIndex < word.length) {
            if (s[sIndex] === word[wordIndex]) {
                wordIndex++;
            }
            sIndex++;
        }

        if (wordIndex === word.length) {
            count++;
            map.set(word, 1);
        } else {
            map.set(word, 0);
        }
    }

    return count;
};