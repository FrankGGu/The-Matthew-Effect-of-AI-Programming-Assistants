var getMirrorReflection = function(p, q) {
    let m = 1, n = 1;
    while (m * p !== n * q) {
        n++;
        if (m * p < n * q) {
            m++;
        }
    }
    if (n % 2 === 0) {
        return 2;
    } else if (m % 2 === 1) {
        return 1;
    } else {
        return 0;
    }
};