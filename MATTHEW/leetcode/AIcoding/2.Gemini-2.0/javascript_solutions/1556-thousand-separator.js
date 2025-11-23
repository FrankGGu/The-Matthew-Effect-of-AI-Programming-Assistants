var thousandSeparator = function(n) {
    const s = String(n);
    let res = "";
    let count = 0;
    for (let i = s.length - 1; i >= 0; i--) {
        res = s[i] + res;
        count++;
        if (count === 3 && i !== 0) {
            res = "." + res;
            count = 0;
        }
    }
    return res;
};