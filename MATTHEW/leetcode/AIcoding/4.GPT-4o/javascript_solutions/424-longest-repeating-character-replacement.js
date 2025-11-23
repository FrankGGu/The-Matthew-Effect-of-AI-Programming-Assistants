var characterReplacement = function(s, k) {
    let count = new Array(26).fill(0);
    let maxCount = 0;
    let left = 0;

    for (let right = 0; right < s.length; right++) {
        count[s[right].charCodeAt() - 'A'.charCodeAt()]++;
        maxCount = Math.max(maxCount, count[s[right].charCodeAt() - 'A'.charCodeAt()]);

        if (right - left + 1 - maxCount > k) {
            count[s[left].charCodeAt() - 'A'.charCodeAt()]--;
            left++;
        }
    }

    return s.length - left;
};