var countCompleteSubstrings = function(word, k) {
    let n = word.length;
    let count = 0;
    for (let len = 1; len <= n; len++) {
        if (len % k !== 0) continue;
        for (let i = 0; i <= n - len; i++) {
            let sub = word.substring(i, i + len);
            let freq = new Array(26).fill(0);
            for (let char of sub) {
                freq[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
            }
            let complete = true;
            for (let j = 0; j < 26; j++) {
                if (freq[j] > 0 && freq[j] !== k) {
                    complete = false;
                    break;
                }
            }
            if (complete) {
                count++;
            }
        }
    }
    return count;
};