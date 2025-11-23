var maxProduct = function(words) {
    let n = words.length;
    let masks = new Array(n).fill(0);
    for (let i = 0; i < n; i++) {
        for (let char of words[i]) {
            masks[i] |= (1 << (char.charCodeAt(0) - 'a'.charCodeAt(0)));
        }
    }

    let maxProd = 0;
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            if ((masks[i] & masks[j]) === 0) {
                maxProd = Math.max(maxProd, words[i].length * words[j].length);
            }
        }
    }
    return maxProd;
};