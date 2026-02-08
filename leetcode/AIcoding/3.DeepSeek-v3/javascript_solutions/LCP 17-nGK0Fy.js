var calculate = function(s) {
    let x = 1, y = 0;
    for (const c of s) {
        if (c === 'A') {
            x = 2 * x + y;
        } else if (c === 'B') {
            y = 2 * y + x;
        }
    }
    return x + y;
};