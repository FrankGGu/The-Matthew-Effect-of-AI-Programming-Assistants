var findAnagrams = function(s, p) {
    const result = [];
    const pLen = p.length;
    const sLen = s.length;
    if (pLen > sLen) return result;

    const pCount = new Array(26).fill(0);
    const sCount = new Array(26).fill(0);

    for (let i = 0; i < pLen; i++) {
        pCount[p.charCodeAt(i) - 'a'.charCodeAt(0)]++;
        sCount[s.charCodeAt(i) - 'a'.charCodeAt(0)]++;
    }

    if (arraysEqual(pCount, sCount)) {
        result.push(0);
    }

    for (let i = pLen; i < sLen; i++) {
        sCount[s.charCodeAt(i - pLen) - 'a'.charCodeAt(0)]--;
        sCount[s.charCodeAt(i) - 'a'.charCodeAt(0)]++;

        if (arraysEqual(pCount, sCount)) {
            result.push(i - pLen + 1);
        }
    }

    return result;
};

function arraysEqual(a, b) {
    for (let i = 0; i < 26; i++) {
        if (a[i] !== b[i]) return false;
    }
    return true;
}