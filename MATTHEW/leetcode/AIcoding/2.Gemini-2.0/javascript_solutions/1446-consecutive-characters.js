var maxPower = function(s) {
    let max = 1;
    let count = 1;
    for (let i = 1; i < s.length; i++) {
        if (s[i] === s[i - 1]) {
            count++;
        } else {
            max = Math.max(max, count);
            count = 1;
        }
    }
    max = Math.max(max, count);
    return max;
};