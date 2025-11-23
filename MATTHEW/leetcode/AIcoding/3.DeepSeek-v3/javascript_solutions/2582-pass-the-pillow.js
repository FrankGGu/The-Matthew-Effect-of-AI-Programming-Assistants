var passThePillow = function(n, time) {
    const cycle = 2 * (n - 1);
    const remainder = time % cycle;
    return remainder < n ? remainder + 1 : n - (remainder - n + 1);
};