var longestCommonSubpath = function(n, paths) {
    const m = paths.length;
    let minLen = Infinity;
    for (const path of paths) {
        minLen = Math.min(minLen, path.length);
    }

    if (minLen === 0) {
        return 0;
    }

    const BASE1 = 200003; 
    const MOD1 = 1_000_000_007;
    const BASE2 = 200009; 
    const MOD2 = 1_000_000_009;

    const pow1 = new Array(minLen + 1);
    const pow2 = new Array(minLen + 1);

    pow1[0] = 1;
    pow2[0] = 1;
    for (let i = 1; i <= minLen; i++) {
        pow1[i] = (pow1[i - 1] * BASE1) % MOD1;
        pow2[i] = (pow2[i - 1] * BASE2) % MOD2;
    }

    function check(k) {
        if (k === 0) return true;

        const counts = new Map();

        for (let i = 0; i < m; i++) {
            const path = paths[i];

            const currentPathHashes = new Set();

            let hash1 = 0;
            let hash2 = 0;

            for (let j = 0; j < k; j++) {
                hash1 = (hash1 * BASE1 + path[j]) % MOD1;
                hash2 = (hash2 * BASE2 + path[j]) % MOD2;
            }
            currentPathHashes.add(`${hash1},${hash2}`);

            for (let j = k; j < path.length; j++) {
                hash1 = (hash1 - (path[j - k] * pow1[k - 1]) % MOD1 + MOD1) % MOD1;
                hash1 = (hash1 * BASE1 + path[j]) % MOD1;

                hash2 = (hash2 - (path[j - k] * pow2[k - 1]) % MOD2 + MOD2) % MOD2;
                hash2 = (hash2 * BASE2 + path[j]) % MOD2;

                currentPathHashes.add(`${hash1},${hash2}`);
            }

            for (const hashPairStr of currentPathHashes) {
                counts.set(hashPairStr, (counts.get(hashPairStr) || 0) + 1);
            }
        }

        for (const [hashPairStr, count] of counts.entries()) {
            if (count === m) {
                return true;
            }
        }

        return false;
    }

    let low = 0;
    let high = minLen;
    let ans = 0;

    while (low <= high) {
        let mid = Math.floor((low + high) / 2);
        if (check(mid)) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return ans;
};