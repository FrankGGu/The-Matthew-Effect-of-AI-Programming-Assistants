var partitionString = function(s) {
    let count = 1;
    let set = new Set();
    for (let i = 0; i < s.length; i++) {
        if (set.has(s[i])) {
            count++;
            set.clear();
        }
        set.add(s[i]);
    }
    return count;
};