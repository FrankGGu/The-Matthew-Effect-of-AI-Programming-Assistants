var similarPairs = function(words) {
    const getMask = (word) => {
        let mask = 0;
        for (const char of new Set(word)) {
            mask |= 1 << (char.charCodeAt(0) - 'a'.charCodeAt(0));
        }
        return mask;
    };

    const masks = words.map(getMask);
    let count = 0;

    for (let i = 0; i < masks.length; i++) {
        for (let j = i + 1; j < masks.length; j++) {
            if ((masks[i] & masks[j]) === masks[i] || (masks[i] & masks[j]) === masks[j]) {
                count++;
            }
        }
    }

    return count;
};