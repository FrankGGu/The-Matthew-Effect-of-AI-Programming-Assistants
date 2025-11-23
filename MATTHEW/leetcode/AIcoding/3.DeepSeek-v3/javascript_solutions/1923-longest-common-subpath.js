var longestCommonSubpath = function(n, paths) {
    let left = 1, right = Math.min(...paths.map(p => p.length));
    let answer = 0;

    const base1 = 100001, base2 = 100007;
    const mod1 = 1000000007, mod2 = 1000000009;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        if (check(mid)) {
            answer = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    function check(len) {
        const map = new Map();
        const pow1 = new Array(len + 1).fill(1);
        const pow2 = new Array(len + 1).fill(1);

        for (let i = 1; i <= len; i++) {
            pow1[i] = (pow1[i - 1] * base1) % mod1;
            pow2[i] = (pow2[i - 1] * base2) % mod2;
        }

        for (let i = 0; i < paths.length; i++) {
            const path = paths[i];
            const set = new Set();
            let hash1 = 0, hash2 = 0;

            for (let j = 0; j < len; j++) {
                hash1 = (hash1 * base1 + path[j]) % mod1;
                hash2 = (hash2 * base2 + path[j]) % mod2;
            }

            const key = `${hash1},${hash2}`;
            if (i === 0) {
                map.set(key, 1);
            } else if (map.has(key) && !set.has(key)) {
                map.set(key, map.get(key) + 1);
                set.add(key);
            }

            for (let j = len; j < path.length; j++) {
                hash1 = (hash1 - path[j - len] * pow1[len - 1] % mod1 + mod1) % mod1;
                hash1 = (hash1 * base1 + path[j]) % mod1;

                hash2 = (hash2 - path[j - len] * pow2[len - 1] % mod2 + mod2) % mod2;
                hash2 = (hash2 * base2 + path[j]) % mod2;

                const newKey = `${hash1},${hash2}`;
                if (i === 0) {
                    map.set(newKey, 1);
                } else if (map.has(newKey) && !set.has(newKey)) {
                    map.set(newKey, map.get(newKey) + 1);
                    set.add(newKey);
                }
            }
        }

        for (const [key, count] of map) {
            if (count === paths.length) {
                return true;
            }
        }
        return false;
    }

    return answer;
};