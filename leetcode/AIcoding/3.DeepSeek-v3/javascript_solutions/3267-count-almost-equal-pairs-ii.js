var countAlmostEqualPairs = function(words) {
    const n = words.length;
    let count = 0;
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const a = words[i];
            const b = words[j];
            if (a.length !== b.length) continue;
            let diff = 0;
            for (let k = 0; k < a.length; k++) {
                if (a[k] !== b[k]) diff++;
                if (diff > 2) break;
            }
            if (diff <= 2) count++;
        }
    }
    return count;
};