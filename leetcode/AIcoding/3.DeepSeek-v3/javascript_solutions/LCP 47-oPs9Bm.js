var checkInclusion = function(s1, s2) {
    const len1 = s1.length, len2 = s2.length;
    if (len1 > len2) return false;

    const count = new Array(26).fill(0);
    for (let i = 0; i < len1; i++) {
        count[s1.charCodeAt(i) - 'a'.charCodeAt(0)]++;
        count[s2.charCodeAt(i) - 'a'.charCodeAt(0)]--;
    }

    if (allZero(count)) return true;

    for (let i = len1; i < len2; i++) {
        count[s2.charCodeAt(i) - 'a'.charCodeAt(0)]--;
        count[s2.charCodeAt(i - len1) - 'a'.charCodeAt(0)]++;
        if (allZero(count)) return true;
    }

    return false;
};

function allZero(count) {
    for (let i = 0; i < 26; i++) {
        if (count[i] !== 0) return false;
    }
    return true;
}