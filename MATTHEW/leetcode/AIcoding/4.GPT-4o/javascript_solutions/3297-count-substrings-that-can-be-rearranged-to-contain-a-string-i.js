var countSubstrings = function(s, t) {
    let count = 0;
    for (let i = 0; i < s.length; i++) {
        for (let j = i; j < s.length; j++) {
            const substring = s.slice(i, j + 1);
            if (canRearrange(substring, t)) {
                count++;
            }
        }
    }
    return count;
};

function canRearrange(s, t) {
    const sCount = Array(26).fill(0);
    const tCount = Array(26).fill(0);

    for (const char of s) {
        sCount[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    for (const char of t) {
        tCount[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    for (let i = 0; i < 26; i++) {
        if (sCount[i] < tCount[i]) {
            return false;
        }
    }
    return true;
}