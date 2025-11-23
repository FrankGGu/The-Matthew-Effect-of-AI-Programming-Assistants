function numSpecialEquivGroups(strs) {
    const set = new Set();
    for (const str of strs) {
        const even = [];
        const odd = [];
        for (let i = 0; i < str.length; i++) {
            if (i % 2 === 0) {
                even.push(str[i]);
            } else {
                odd.push(str[i]);
            }
        }
        even.sort();
        odd.sort();
        set.add(even.join('') + odd.join(''));
    }
    return set.size;
}