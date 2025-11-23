var divisorSubstrings = function(n, k) {
    let s = n.toString();
    let count = 0;
    for (let i = 0; i <= s.length - k; i++) {
        let sub = parseInt(s.substring(i, i + k));
        if (sub !== 0 && n % sub === 0) {
            count++;
        }
    }
    return count;
};