function areDigitsEqual(s, t) {
    const count = (str) => {
        const freq = new Array(10).fill(0);
        for (const c of str) {
            freq[parseInt(c)]++;
        }
        return freq;
    };

    const sFreq = count(s);
    const tFreq = count(t);

    for (let i = 0; i < 10; i++) {
        if (sFreq[i] !== tFreq[i]) {
            return false;
        }
    }

    return true;
}