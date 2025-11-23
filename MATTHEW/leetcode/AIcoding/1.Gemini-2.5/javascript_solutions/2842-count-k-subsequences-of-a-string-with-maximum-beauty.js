var countKSubsequencesWithMaxBeauty = function(s, k) {
    const freqMap = new Map();
    for (const char of s) {
        freqMap.set(char, (freqMap.get(char) || 0) + 1);
    }

    const frequencies = Array.from(freqMap.values());

    if (frequencies.length < k) {
        return 0;
    }

    frequencies.sort((a, b) => b - a);

    const minFreqToInclude = frequencies[k - 1];

    let countGreater = 0;
    for (let i = 0; i < k; i++) {
        if (frequencies[i] > minFreqToInclude) {
            countGreater++;
        } else {
            break;
        }
    }

    let countEqual = 0;
    for (const freq of frequencies) {
        if (freq === minFreqToInclude) {
            countEqual++;
        }
    }

    const neededFromEqual = k - countGreater;

    function combinations(n, r) {
        if (r < 0 || r > n) {
            return 0;
        }
        if (r === 0 || r === n) {
            return 1;
        }
        if (r > n / 2) {
            r = n - r;
        }
        let res = 1;
        for (let i = 1; i <= r; i++) {
            res = res * (n - i + 1) / i;
        }
        return res;
    }

    return combinations(countEqual, neededFromEqual);
};