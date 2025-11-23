var checkInclusion = function(s1, s2) {
    if (s1.length > s2.length) return false;

    const s1Map = new Array(26).fill(0);
    const s2Map = new Array(26).fill(0);

    for (let i = 0; i < s1.length; i++) {
        s1Map[s1.charCodeAt(i) - 'a'.charCodeAt(0)]++;
        s2Map[s2.charCodeAt(i) - 'a'.charCodeAt(0)]++;
    }

    let matches = 0;
    for (let i = 0; i < 26; i++) {
        if (s1Map[i] === s2Map[i]) matches++;
    }

    for (let i = 0; i < s2.length - s1.length; i++) {
        if (matches === 26) return true;

        let left = s2.charCodeAt(i) - 'a'.charCodeAt(0);
        let right = s2.charCodeAt(i + s1.length) - 'a'.charCodeAt(0);

        s2Map[left]--;
        if (s2Map[left] === s1Map[left]) {
            matches++;
        } else if (s2Map[left] === s1Map[left] - 1) {
            matches--;
        }

        s2Map[right]++;
        if (s2Map[right] === s1Map[right]) {
            matches++;
        } else if (s2Map[right] === s1Map[right] + 1) {
            matches--;
        }
    }

    return matches === 26;
};