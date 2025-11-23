function findTheLongestBalancedSubstring(s) {
    let maxLength = 0;
    let count0 = 0, count1 = 0;

    for (let i = 0; i < s.length; i++) {
        if (s[i] === '0') {
            count0++;
        } else {
            count1++;
        }

        if (count0 === count1) {
            maxLength = Math.max(maxLength, count0 + count1);
        }

        if (count1 > count0) {
            count0 = 0;
            count1 = 0;
        }
    }

    return maxLength;
}