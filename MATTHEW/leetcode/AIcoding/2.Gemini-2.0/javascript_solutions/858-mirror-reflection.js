var mirrorReflection = function(p, q) {
    let m = 1;
    let n = 1;
    while (m * p !== n * q) {
        n++;
        m = (n * q) / p;
    }
    if (m % 2 === 0 && n % 2 !== 0) {
        return 0;
    } else if (m % 2 !== 0 && n % 2 !== 0) {
        return 1;
    } else {
        return 2;
    }
};