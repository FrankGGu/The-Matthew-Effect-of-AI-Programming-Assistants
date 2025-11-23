var permutationDifference = function(s1, s2) {
    const count = (str) => {
        const freq = new Array(26).fill(0);
        for (const char of str) {
            freq[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
        }
        return freq;
    };

    const freq1 = count(s1);
    const freq2 = count(s2);

    let diff = 0;
    for (let i = 0; i < 26; i++) {
        diff += Math.abs(freq1[i] - freq2[i]);
    }

    return diff;
};