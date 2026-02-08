var checkValidString = function(s) {
    let min = 0, max = 0;
    for (let c of s) {
        if (c === '(') {
            min++;
            max++;
        } else if (c === ')') {
            min--;
            max--;
        } else {
            min--;
            max++;
        }
        if (max < 0) return false;
        min = Math.max(min, 0);
    }
    return min === 0;
};