var subStrHash = function(s, power, modulo, k, hashValue) {
    const n = s.length;
    let hash = 0;
    let powerK = 1;

    for (let i = n - k; i < n; i++) {
        hash = (hash * power + (s.charCodeAt(i) - 'a'.charCodeAt(0) + 1)) % modulo) % modulo;
        if (i !== n - k) {
            powerK = (powerK * power) % modulo;
        }
    }

    let res = -1;
    if (hash === hashValue) {
        res = n - k;
    }

    for (let i = n - k - 1; i >= 0; i--) {
        const rightChar = s.charCodeAt(i + k) - 'a'.charCodeAt(0) + 1;
        const leftChar = s.charCodeAt(i) - 'a'.charCodeAt(0) + 1;
        hash = (hash - (rightChar * powerK) % modulo + modulo) % modulo;
        hash = (hash * power + leftChar) % modulo;

        if (hash === hashValue) {
            res = i;
        }
    }

    return s.substring(res, res + k);
};