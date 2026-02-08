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

    let matches = 0;
    for (let i = 0; i < 26; i++) {
        if (pCount[i] === sCount[i]) matches++;
    }

    let left = 0;
    for (let right = pLen; right < sLen; right++) {
        if (matches === 26) result.push(left);

        const index = s.charCodeAt(right) - 'a'.charCodeAt(0);
        sCount[index]++;
        if (sCount[index] === pCount[index]) {
            matches++;
        } else if (sCount[index] === pCount[index] + 1) {
            matches--;
        }

        const leftIndex = s.charCodeAt(left) - 'a'.charCodeAt(0);
        sCount[leftIndex]--;
        if (sCount[leftIndex] === pCount[leftIndex]) {
            matches++;
        } else if (sCount[leftIndex] === pCount[leftIndex] - 1) {
            matches--;
        }
        left++;
    }

    if (matches === 26) result.push(left);

    return result;
};