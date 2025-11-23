var minimizeStringValue = function(s) {
    const n = s.length;
    const freq = new Array(26).fill(0);
    const questionIndices = [];
    const res = s.split('');

    for (let i = 0; i < n; i++) {
        if (s[i] !== '?') {
            freq[s.charCodeAt(i) - 'a'.charCodeAt(0)]++;
        } else {
            questionIndices.push(i);
        }
    }

    const charsToPlace = [];
    for (let i = 0; i < questionIndices.length; i++) {
        let minFreq = Infinity;
        let minChar = 'a';
        for (let c = 0; c < 26; c++) {
            if (freq[c] < minFreq) {
                minFreq = freq[c];
                minChar = String.fromCharCode(c + 'a'.charCodeAt(0));
            }
        }
        charsToPlace.push(minChar);
        freq[minChar.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    charsToPlace.sort();
    for (let i = 0; i < questionIndices.length; i++) {
        res[questionIndices[i]] = charsToPlace[i];
    }

    return res.join('');
};