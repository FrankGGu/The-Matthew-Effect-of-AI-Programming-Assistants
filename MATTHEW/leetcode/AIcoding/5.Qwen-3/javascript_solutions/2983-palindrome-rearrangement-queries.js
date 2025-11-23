function canReorderToPalindrome(s, queries) {
    const count = new Array(26).fill(0);
    for (let c of s) {
        count[c.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    const result = [];
    for (let q of queries) {
        const [pos, ch] = q;
        const idx = s[pos].charCodeAt(0) - 'a'.charCodeAt(0);
        count[idx]--;
        const newIdx = ch.charCodeAt(0) - 'a'.charCodeAt(0);
        count[newIdx]++;
        s = s.substring(0, pos) + ch + s.substring(pos + 1);

        let oddCount = 0;
        for (let i = 0; i < 26; i++) {
            if (count[i] % 2 !== 0) {
                oddCount++;
            }
        }
        result.push(oddCount <= 1);
    }

    return result;
}