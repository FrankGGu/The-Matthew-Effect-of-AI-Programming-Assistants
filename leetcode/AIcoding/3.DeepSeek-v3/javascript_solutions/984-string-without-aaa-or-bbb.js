var strWithout3a3b = function(a, b) {
    let res = [];
    while (a > 0 || b > 0) {
        let writeA = false;
        if (res.length >= 2 && res[res.length - 1] === res[res.length - 2]) {
            if (res[res.length - 1] === 'b') {
                writeA = true;
            }
        } else {
            if (a >= b) {
                writeA = true;
            }
        }
        if (writeA) {
            if (a === 0) {
                return '';
            }
            res.push('a');
            a--;
        } else {
            if (b === 0) {
                return '';
            }
            res.push('b');
            b--;
        }
    }
    return res.join('');
};