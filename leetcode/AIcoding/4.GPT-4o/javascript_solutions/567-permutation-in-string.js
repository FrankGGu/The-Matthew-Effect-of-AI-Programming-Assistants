var checkInclusion = function(s1, s2) {
    const countS1 = new Array(26).fill(0);
    const countS2 = new Array(26).fill(0);

    for (let char of s1) {
        countS1[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    const len1 = s1.length;
    const len2 = s2.length;

    for (let i = 0; i < Math.min(len1, len2); i++) {
        countS2[s2[i].charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    if (countS1.toString() === countS2.toString()) return true;

    for (let i = len1; i < len2; i++) {
        countS2[s2[i].charCodeAt(0) - 'a'.charCodeAt(0)]++;
        countS2[s2[i - len1].charCodeAt(0) - 'a'.charCodeAt(0)]--;

        if (countS1.toString() === countS2.toString()) return true;
    }

    return false;
};