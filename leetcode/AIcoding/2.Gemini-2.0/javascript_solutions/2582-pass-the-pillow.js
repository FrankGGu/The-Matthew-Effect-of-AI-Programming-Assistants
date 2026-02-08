var passThePillow = function(n, time) {
    let period = n - 1;
    let rem = time % (2 * period);
    if (rem <= period) {
        return rem + 1;
    } else {
        return n - (rem - period);
    }
};