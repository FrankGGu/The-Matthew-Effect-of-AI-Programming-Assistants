function longestDupSubstring(s) {
    const n = s.length;
    const nums = new Array(n).fill(0).map((_, i) => s.charCodeAt(i));

    const base = 26;
    const mod = Math.pow(2, 32);

    function search(L) {
        let hash = 0;
        for (let i = 0; i < L; i++) {
            hash = (hash * base + nums[i]) % mod;
        }

        const seen = new Set();
        seen.add(hash);

        const baseL = Math.pow(base, L) % mod;

        for (let start = 1; start < n - L + 1; start++) {
            hash = (hash * base - nums[start - 1] * baseL + nums[start + L - 1]) % mod;
            if (hash < 0) hash += mod;
            if (seen.has(hash)) {
                return start;
            }
            seen.add(hash);
        }

        return -1;
    }

    let left = 1;
    let right = n;
    let result = 0;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        const index = search(mid);
        if (index !== -1) {
            result = index;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return s.substring(result, result + (right + 1));
}