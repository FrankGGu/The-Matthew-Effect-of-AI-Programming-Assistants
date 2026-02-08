var queryString = function(s, n) {
    for (let i = 1; i <= n; i++) {
        let binary = i.toString(2);
        if (s.indexOf(binary) === -1) {
            return false;
        }
    }
    return true;
};