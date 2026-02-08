function longestSubsequence(s, k) {
    let count = 0;
    let num = 0;

    for (let i = s.length - 1; i >= 0; i--) {
        if (s[i] === '0') {
            count++;
        } else if (num + (1 << count) <= k) {
            num += (1 << count);
            count++;
        }
    }

    return count;
}