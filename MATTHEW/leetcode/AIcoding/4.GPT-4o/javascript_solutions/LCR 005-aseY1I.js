var maxProduct = function(words) {
    const n = words.length;
    const masks = new Array(n);

    for (let i = 0; i < n; i++) {
        let mask = 0;
        for (const char of words[i]) {
            mask |= 1 << (char.charCodeAt(0) - 'a'.charCodeAt(0));
        }
        masks[i] = mask;
    }

    let maxProduct = 0;
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            if ((masks[i] & masks[j]) === 0) {
                maxProduct = Math.max(maxProduct, words[i].length * words[j].length);
            }
        }
    }

    return maxProduct;
};