function findTheLongestSubstring(s) {
    const map = new Map();
    map.set(0, -1);
    let res = 0;
    let mask = 0;
    for (let i = 0; i < s.length; i++) {
        const c = s[i];
        if (c === 'a') mask ^= 1 << 0;
        else if (c === 'c') mask ^= 1 << 1;
        else if (c === 'g') mask ^= 1 << 2;
        else if (c === 't') mask ^= 1 << 3;
        if (map.has(mask)) {
            res = Math.max(res, i - map.get(mask));
        } else {
            map.set(mask, i);
        }
    }
    return res;
}