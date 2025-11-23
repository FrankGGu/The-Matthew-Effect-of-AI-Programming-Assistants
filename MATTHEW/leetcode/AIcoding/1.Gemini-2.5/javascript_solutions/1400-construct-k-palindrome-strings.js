var canConstruct = function(s, k) {
    const n = s.length;

    if (n < k) {
        return false;
    }

    const freq = new Array(26).fill(0);
    for (let i = 0; i < n; i++) {
        freq[s.charCodeAt(i) - 'a'.charCodeAt(0)]++;
    }

    let oddCount = 0;
    for (let i = 0; i < 26; i++) {
        if (freq[i] % 2 !== 0) {
            oddCount++;
        }
    }

    if (oddCount > k) {
        return false;
    }

    return true;
};