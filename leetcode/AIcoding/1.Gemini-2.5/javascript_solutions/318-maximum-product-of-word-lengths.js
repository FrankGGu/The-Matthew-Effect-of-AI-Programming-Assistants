var maxProduct = function(words) {
    const n = words.length;
    const masks = new Array(n);
    const lengths = new Array(n);

    for (let i = 0; i < n; i++) {
        let mask = 0;
        const word = words[i];
        for (let j = 0; j < word.length; j++) {
            mask |= (1 << (word.charCodeAt(j) - 'a'.charCodeAt(0)));
        }
        masks[i] = mask;
        lengths[i] = word.length;
    }

    let maxProd = 0;
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            if ((masks[i] & masks[j]) === 0) {
                maxProd = Math.max(maxProd, lengths[i] * lengths[j]);
            }
        }
    }

    return maxProd;
};