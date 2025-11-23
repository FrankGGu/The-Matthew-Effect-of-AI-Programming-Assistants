function groupAnagrams(strs) {
    const map = {};
    for (const str of strs) {
        const key = str.split('').sort().join('');
        if (!map[key]) {
            map[key] = [];
        }
        map[key].push(str);
    }
    return Object.values(map);
}