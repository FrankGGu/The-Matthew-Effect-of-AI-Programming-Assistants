var longestDupSubstring = function(s) {
    const n = s.length;
    const base = 26;
    const mod = 2 ** 32;
    let left = 1, right = n;
    let result = "";

    const search = (L) => {
        const seen = new Set();
        let hash = 0;
        let aL = 1;
        for (let i = 0; i < L; i++) {
            hash = (hash * base + s.charCodeAt(i)) % mod;
        }
        seen.add(hash);
        for (let i = 1; i <= n - L; i++) {
            aL = (aL * base) % mod;
            hash = (hash * base - s.charCodeAt(i - 1) * aL % mod + mod) % mod;
            hash = (hash + s.charCodeAt(i + L - 1)) % mod;
            if (seen.has(hash)) {
                return i;
            }
            seen.add(hash);
        }
        return -1;
    };

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        const index = search(mid);
        if (index !== -1) {
            left = mid + 1;
            result = s.substring(index, index + mid);
        } else {
            right = mid - 1;
        }
    }
    return result;
};