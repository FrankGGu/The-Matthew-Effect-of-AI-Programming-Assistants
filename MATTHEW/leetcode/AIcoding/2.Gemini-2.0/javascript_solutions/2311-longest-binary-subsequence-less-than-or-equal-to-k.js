var longestSubsequence = function(s, k) {
    let count = 0;
    let num = 0;
    let power = 1;

    for (let i = s.length - 1; i >= 0; i--) {
        if (s[i] === '0') {
            count++;
        } else {
            if (num + power <= k) {
                num += power;
                count++;
            }
        }
        if (power <= k) {
            power *= 2;
        }
    }

    return count;
};