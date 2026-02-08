var maxProduct = function(words) {
    const masks = words.map(word => {
        let mask = 0;
        for (const c of word) {
            mask |= 1 << (c.charCodeAt() - 'a'.charCodeAt());
        }
        return mask;
    });

    let max = 0;
    for (let i = 0; i < words.length; i++) {
        for (let j = i + 1; j < words.length; j++) {
            if ((masks[i] & masks[j]) === 0) {
                max = Math.max(max, words[i].length * words[j].length);
            }
        }
    }
    return max;
};