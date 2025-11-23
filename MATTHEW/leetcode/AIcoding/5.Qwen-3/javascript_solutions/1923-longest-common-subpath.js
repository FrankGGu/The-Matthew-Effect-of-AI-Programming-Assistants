function longestCommonSubpath(n, paths) {
    const mod = 10 ** 9 + 7;
    const base = 256;

    function getHashes(arr, len) {
        const hashes = new Array(arr.length);
        const power = new Array(len + 1).fill(1);
        for (let i = 1; i <= len; i++) {
            power[i] = (power[i - 1] * base) % mod;
        }
        let hash = 0;
        for (let i = 0; i < len; i++) {
            hash = (hash * base + arr[i]) % mod;
        }
        hashes[0] = hash;
        for (let i = 1; i < arr.length; i++) {
            hash = (hash - arr[i - 1] * power[len]) % mod;
            hash = (hash * base + arr[i + len - 1]) % mod;
            if (hash < 0) hash += mod;
            hashes[i] = hash;
        }
        return hashes;
    }

    function findCommon(hashesList) {
        const set = new Set(hashesList[0]);
        for (let i = 1; i < hashesList.length; i++) {
            const temp = new Set();
            for (const h of hashesList[i]) {
                if (set.has(h)) {
                    temp.add(h);
                }
            }
            set.clear();
            set = temp;
            if (set.size === 0) return 0;
        }
        return set.size > 0 ? 1 : 0;
    }

    let low = 0, high = Math.min(...paths.map(p => p.length));
    let result = 0;

    while (low <= high) {
        const mid = (low + high) >> 1;
        const hashesList = paths.map(p => getHashes(p, mid));
        const common = findCommon(hashesList);
        if (common > 0) {
            result = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return result;
}