var countKeyChanges = function(s) {
    let count = 0;
    s = s.toLowerCase();
    for (let i = 1; i < s.length; i++) {
        if (s[i] !== s[i - 1]) {
            count++;
        }
    }
    return count;
};