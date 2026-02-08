var dynamicPassword = function(s, k) {
    if (!s || s.length === 0) {
        return s;
    }
    const n = s.length;
    k = k % n;
    if (k < 0) {
        k = k + n;
    }
    return s.substring(k) + s.substring(0, k);
};