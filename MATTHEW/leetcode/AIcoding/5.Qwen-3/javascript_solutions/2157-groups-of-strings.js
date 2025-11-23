function groupStrings(stringList) {
    const map = {};

    for (const s of stringList) {
        const key = [];
        for (let i = 1; i < s.length; i++) {
            key.push((s[i].charCodeAt(0) - s[i - 1].charCodeAt(0) + 26) % 26);
        }
        const keyStr = key.join(',');
        if (!map[keyStr]) {
            map[keyStr] = [];
        }
        map[keyStr].push(s);
    }

    return Object.values(map);
}