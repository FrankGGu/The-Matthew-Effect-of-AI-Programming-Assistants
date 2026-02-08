var beautifulSubstrings = function(s, k) {
    const n = s.length;
    const vowels = new Set(['a', 'e', 'i', 'o', 'u']);
    let count = 0;
    const prefix = new Map();
    prefix.set(0, new Map());
    prefix.get(0).set(0, 1);

    let v = 0, c = 0;
    for (let i = 0; i < n; i++) {
        if (vowels.has(s[i])) {
            v++;
        } else {
            c++;
        }
        const key = v - c;
        const mod = ((v * c) % k + k) % k;
        if (!prefix.has(key)) {
            prefix.set(key, new Map());
        }
        const modMap = prefix.get(key);
        if (modMap.has(mod)) {
            count += modMap.get(mod);
        }
        if (!modMap.has(mod)) {
            modMap.set(mod, 0);
        }
        modMap.set(mod, modMap.get(mod) + 1);
    }
    return count;
};