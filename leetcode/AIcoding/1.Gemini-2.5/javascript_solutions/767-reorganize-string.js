function reorganizeString(S) {
    const N = S.length;
    if (N === 0) {
        return "";
    }

    const counts = new Array(26).fill(0);
    for (let i = 0; i < N; i++) {
        counts[S.charCodeAt(i) - 'a'.charCodeAt(0)]++;
    }

    const charFreqs = [];
    for (let i = 0; i < 26; i++) {
        if (counts[i] > 0) {
            charFreqs.push({ char: String.fromCharCode('a'.charCodeAt(0) + i), freq: counts[i] });
        }
    }

    charFreqs.sort((a, b) => b.freq - a.freq);

    if (charFreqs[0].freq > (N + 1) / 2) {
        return "";
    }

    const result = new Array(N);
    let idx = 0;

    for (const { char, freq } of charFreqs) {
        let currentFreq = freq;
        while (currentFreq > 0) {
            if (idx >= N) {
                idx = 1;
            }
            result[idx] = char;
            idx += 2;
            currentFreq--;
        }
    }

    return result.join('');
}