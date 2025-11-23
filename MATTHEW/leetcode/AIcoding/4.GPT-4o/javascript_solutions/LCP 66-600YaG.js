var minNumberOfBooths = function (demand) {
    const count = new Array(26).fill(0);
    for (let char of demand) {
        count[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    let maxBooths = 0;
    for (let i = 0; i < 26; i++) {
        if (count[i] > 0) {
            maxBooths = Math.max(maxBooths, count[i]);
        }
    }

    return maxBooths;
};