var longestCommonSubpath = function(n, paths) {
    let low = 0, high = Math.min(...paths.map(path => path.length));
    let result = 0;

    while (low <= high) {
        const mid = Math.floor((low + high) / 2);
        if (check(paths, mid, n)) {
            result = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return result;

    function check(paths, len, n) {
        const MOD = 10**9 + 7;
        const BASE = 31;

        if (len === 0) return true;

        let seenHashes = new Set();
        for (let i = 0; i <= paths[0].length - len; i++) {
            let hash = 0;
            let power = 1;
            for (let j = i + len - 1; j >= i; j--) {
                hash = (hash + (paths[0][j] + 1) * power) % MOD;
                if (j > i) power = (power * BASE) % MOD;
            }
            seenHashes.add(hash);
        }

        for (let i = 1; i < paths.length; i++) {
            let currentHashes = new Set();
            for (let j = 0; j <= paths[i].length - len; j++) {
                let hash = 0;
                let power = 1;
                for (let k = j + len - 1; k >= j; k--) {
                    hash = (hash + (paths[i][k] + 1) * power) % MOD;
                    if (k > j) power = (power * BASE) % MOD;
                }
                if (seenHashes.has(hash)) {
                    currentHashes.add(hash);
                }
            }
            seenHashes = currentHashes;
            if (seenHashes.size === 0) return false;
        }

        return seenHashes.size > 0;
    }
};