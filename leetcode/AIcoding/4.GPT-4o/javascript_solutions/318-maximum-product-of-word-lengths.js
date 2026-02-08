var maxProduct = function(words) {
    let maxProd = 0;
    const bitMasks = words.map(word => {
        let mask = 0;
        for (let char of word) {
            mask |= 1 << (char.charCodeAt(0) - 'a'.charCodeAt(0));
        }
        return mask;
    });

    for (let i = 0; i < words.length; i++) {
        for (let j = i + 1; j < words.length; j++) {
            if ((bitMasks[i] & bitMasks[j]) === 0) {
                maxProd = Math.max(maxProd, words[i].length * words[j].length);
            }
        }
    }

    return maxProd;
};