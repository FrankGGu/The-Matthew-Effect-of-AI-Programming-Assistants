var groupStrings = function(strings) {
    const map = new Map();

    for (const s of strings) {
        let key = '';
        for (let i = 1; i < s.length; i++) {
            const diff = (s.charCodeAt(i) - s.charCodeAt(i - 1) + 26) % 26;
            key += diff + ',';
        }
        if (!map.has(key)) {
            map.set(key, []);
        }
        map.get(key).push(s);
    }

    return Array.from(map.values());
};