var maximumValue = function(strs) {
    let max = 0;
    for (const s of strs) {
        let num = 0;
        let hasAlpha = false;
        for (const c of s) {
            if (isNaN(c)) {
                hasAlpha = true;
                break;
            }
        }
        if (hasAlpha) {
            num = s.length;
        } else {
            num = parseInt(s, 10);
        }
        if (num > max) {
            max = num;
        }
    }
    return max;
};