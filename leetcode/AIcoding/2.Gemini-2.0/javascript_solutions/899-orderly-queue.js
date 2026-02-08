var orderlyQueue = function(s, k) {
    if (k > 1) {
        return s.split('').sort().join('');
    } else {
        let res = s;
        for (let i = 1; i < s.length; i++) {
            let temp = s.substring(i) + s.substring(0, i);
            if (temp < res) {
                res = temp;
            }
        }
        return res;
    }
};