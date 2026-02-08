var substringXorQueries = function(s, queries) {
    const n = s.length;
    const map = new Map();
    for (let i = 0; i < n; i++) {
        if (s[i] === '0') {
            if (!map.has(0)) {
                map.set(0, [i, i]);
            }
            continue;
        }
        let num = 0;
        for (let j = i; j < Math.min(i + 30, n); j++) {
            num = (num << 1) | (s[j] === '1' ? 1 : 0);
            if (!map.has(num)) {
                map.set(num, [i, j]);
            }
        }
    }
    const result = [];
    for (const [a, b] of queries) {
        const target = a ^ b;
        if (map.has(target)) {
            result.push(map.get(target));
        } else {
            result.push([-1, -1]);
        }
    }
    return result;
};