var minimumTimeToInitialState = function(s, k) {
    let n = s.length;
    let count = 1;
    let i = k;
    while (i < n) {
        if (s.substring(i) === s.substring(0, n - i)) {
            break;
        }
        count++;
        i += k;
    }
    return count;
};