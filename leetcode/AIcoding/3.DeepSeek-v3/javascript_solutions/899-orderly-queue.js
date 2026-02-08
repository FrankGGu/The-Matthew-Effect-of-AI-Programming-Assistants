var orderlyQueue = function(s, k) {
    if (k === 1) {
        let min = s;
        for (let i = 0; i < s.length; i++) {
            s = s.substring(1) + s[0];
            if (s < min) min = s;
        }
        return min;
    } else {
        return s.split('').sort().join('');
    }
};