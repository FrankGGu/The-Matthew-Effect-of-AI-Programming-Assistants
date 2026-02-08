var countPalindromicSubsequence = function(s) {
    const first = new Array(26).fill(-1);
    const last = new Array(26).fill(-1);

    for (let i = 0; i < s.length; i++) {
        const charCode = s.charCodeAt(i) - 'a'.charCodeAt(0);
        if (first[charCode] === -1) {
            first[charCode] = i;
        }
        last[charCode] = i;
    }

    let count = 0;
    for (let i = 0; i < 26; i++) {
        if (first[i] === -1) continue;
        const between = new Set();
        for (let j = first[i] + 1; j < last[i]; j++) {
            between.add(s[j]);
        }
        count += between.size;
    }

    return count;
};