var minSteps = function(s, t) {
    const freq = new Array(26).fill(0);
    const aCharCode = 'a'.charCodeAt(0);

    for (let i = 0; i < s.length; i++) {
        freq[s.charCodeAt(i) - aCharCode]++;
    }

    let steps = 0;
    for (let i = 0; i < t.length; i++) {
        const charCode = t.charCodeAt(i) - aCharCode;
        if (freq[charCode] > 0) {
            freq[charCode]--;
        } else {
            steps++;
        }
    }

    return steps;
};