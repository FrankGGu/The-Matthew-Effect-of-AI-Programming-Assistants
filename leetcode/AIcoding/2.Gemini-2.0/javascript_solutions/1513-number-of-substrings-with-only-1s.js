var numSub = function(s) {
    let count = 0;
    let current = 0;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === '1') {
            current++;
        } else {
            count += (current * (current + 1)) / 2;
            current = 0;
        }
    }
    count += (current * (current + 1)) / 2;
    return count;
};