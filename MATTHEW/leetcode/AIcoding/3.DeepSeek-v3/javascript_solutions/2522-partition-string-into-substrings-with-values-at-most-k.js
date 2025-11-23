var minimumPartition = function(s, k) {
    let count = 0;
    let current = 0;
    for (let i = 0; i < s.length; i++) {
        const digit = parseInt(s[i]);
        if (digit > k) {
            return -1;
        }
        current = current * 10 + digit;
        if (current > k) {
            count++;
            current = digit;
        }
    }
    if (current <= k) {
        count++;
    }
    return count;
};