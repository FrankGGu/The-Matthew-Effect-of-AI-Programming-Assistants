function groupAnagrams(strs) {
    const map = new Map();
    for (const str of strs) {
        const key = Array.from(str).sort().join('');
        if (!map.has(key)) {
            map.set(key, []);
        }
        map.get(key).push(str);
    }
    return Array.from(map.values());
}