class Solution {
    longestDupSubstring(S) {
        const n = S.length;
        const mod = 1e9 + 7;
        const base = 256;

        const check = (length) => {
            const seen = new Set();
            let hash = 0;
            let baseL = 1;

            for (let i = 0; i < length; i++) {
                hash = (hash * base + S.charCodeAt(i)) % mod;
                if (i > 0) baseL = (baseL * base) % mod;
            }

            seen.add(hash);

            for (let i = length; i < n; i++) {
                hash = (hash * base - S.charCodeAt(i - length) * baseL + S.charCodeAt(i)) % mod;
                if (hash < 0) hash += mod;
                if (seen.has(hash)) return i - length + 1;
                seen.add(hash);
            }
            return -1;
        };

        let left = 1, right = n, start = 0;

        while (left < right) {
            const mid = Math.floor((left + right) / 2);
            const idx = check(mid);
            if (idx !== -1) {
                start = idx;
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        return S.substring(start, start + left - 1);
    }
}