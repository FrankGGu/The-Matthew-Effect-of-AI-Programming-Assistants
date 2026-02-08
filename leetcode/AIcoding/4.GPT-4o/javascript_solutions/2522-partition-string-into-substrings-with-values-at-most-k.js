var minimumPartition = function(s, k) {
    let count = 0;
    let current = 0;

    for (let i = 0; i < s.length; i++) {
        let num = parseInt(s[i]);
        if (current * 10 + num > k) {
            count++;
            current = num;
            if (current > k) return -1;
        } else {
            current = current * 10 + num;
        }
    }
    return count + (current > 0 ? 1 : 0);
};