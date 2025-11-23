var subStrHash = function(s, power, modulo, k, hashValue) {
    let n = s.length;
    let p = 1;
    for (let i = 1; i < k; i++) {
        p = (p * power) % modulo;
    }

    let currHash = 0;
    for (let i = n - k; i < n; i++) {
        currHash = (currHash * power + (s.charCodeAt(i) - 'a'.charCodeAt(0) + 1)) % modulo;
    }

    if (currHash === hashValue) {
        return s.substring(n - k);
    }

    for (let i = n - k - 1; i >= 0; i--) {
        currHash = (currHash - (s.charCodeAt(i + k) - 'a'.charCodeAt(0) + 1) * p % modulo + modulo) % modulo;
        currHash = (currHash * power + (s.charCodeAt(i) - 'a'.charCodeAt(0) + 1)) % modulo;

        if (currHash === hashValue) {
            return s.substring(i, i + k);
        }
    }

    return "";
};