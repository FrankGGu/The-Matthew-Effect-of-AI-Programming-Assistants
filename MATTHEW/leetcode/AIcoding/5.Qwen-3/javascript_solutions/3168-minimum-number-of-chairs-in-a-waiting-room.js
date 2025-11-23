function minInteger(s) {
    let count = 0;
    let maxCount = 0;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === 'A') {
            count++;
        } else {
            maxCount = Math.max(maxCount, count);
            count = 0;
        }
    }
    return maxCount;
}