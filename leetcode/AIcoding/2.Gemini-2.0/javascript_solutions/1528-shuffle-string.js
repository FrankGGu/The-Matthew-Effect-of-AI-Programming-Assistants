var restoreString = function(s, indices) {
    const n = s.length;
    const shuffled = new Array(n);
    for (let i = 0; i < n; i++) {
        shuffled[indices[i]] = s[i];
    }
    return shuffled.join('');
};