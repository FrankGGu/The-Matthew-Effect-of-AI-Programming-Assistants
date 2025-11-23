var maxNumberOfBalloons = function(text) {
    const charCounts = new Array(26).fill(0);

    for (let i = 0; i < text.length; i++) {
        const charCode = text.charCodeAt(i) - 'a'.charCodeAt(0);
        if (charCode >= 0 && charCode < 26) {
            charCounts[charCode]++;
        }
    }

    let b = charCounts['b'.charCodeAt(0) - 'a'.charCodeAt(0)];
    let a = charCounts['a'.charCodeAt(0) - 'a'.charCodeAt(0)];
    let l = charCounts['l'.charCodeAt(0) - 'a'.charCodeAt(0)];
    let o = charCounts['o'.charCodeAt(0) - 'a'.charCodeAt(0)];
    let n = charCounts['n'.charCodeAt(0) - 'a'.charCodeAt(0)];

    l = Math.floor(l / 2);
    o = Math.floor(o / 2);

    return Math.min(b, a, l, o, n);
};