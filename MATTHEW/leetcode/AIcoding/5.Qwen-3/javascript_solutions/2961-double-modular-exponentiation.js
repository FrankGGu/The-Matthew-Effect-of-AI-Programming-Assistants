function powMod(x, y, z) {
    let result = 1;
    x = x % z;
    while (y > 0) {
        if (y % 2 === 1) {
            result = (result * x) % z;
        }
        x = (x * x) % z;
        y = Math.floor(y / 2);
    }
    return result;
}