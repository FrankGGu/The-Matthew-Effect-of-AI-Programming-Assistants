var minOperations = function(s) {
    let n = s.length;
    let count0 = 0;
    let count1 = 0;

    for (let i = 0; i < n; i++) {
        if (i % 2 === 0) {
            if (s[i] === '1') {
                count0++;
            } else {
                count1++;
            }
        } else {
            if (s[i] === '0') {
                count0++;
            } else {
                count1++;
            }
        }
    }

    return Math.min(count0, count1);
};