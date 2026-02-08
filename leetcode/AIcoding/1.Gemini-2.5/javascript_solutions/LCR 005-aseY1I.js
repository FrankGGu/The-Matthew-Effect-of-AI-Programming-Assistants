var maxProduct = function(words) {
    const n = words.length;
    if (n < 2) {
        return 0;
    }

    const masks = new Array(n);
    const lengths = new Array(n);

    for (let i = 0; i < n; i++) {
        let mask = 0;
        const word = words[i];
        lengths[i] = word.length;
        for (let j = 0; j < word.length; j++) {
            mask |= (1 << (word.charCodeAt(j) - 'a'.charCodeAt(0)));
        }
        masks[i] = mask;
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