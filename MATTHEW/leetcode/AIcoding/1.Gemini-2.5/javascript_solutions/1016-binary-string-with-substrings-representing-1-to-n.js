var queryString = function(s, n) {
    for (let i = 1; i <= n; i++) {
        const binaryString = i.toString(2);
        if (!s.includes(binaryString)) {
            return false;
        }
    }
    return true;
};