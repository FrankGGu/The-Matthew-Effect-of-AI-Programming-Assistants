var binaryGap = function(n) {
    let last = null;
    let ans = 0;
    let idx = 0;
    while (n > 0) {
        if (n % 2 === 1) {
            if (last !== null) {
                ans = Math.max(ans, idx - last);
            }
            last = idx;
        }
        n = Math.floor(n / 2);
        idx++;
    }
    return ans;
};