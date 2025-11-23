var myPow = function(x, n) {
    if (n === 0) {
        return 1;
    }

    let ans = 1.0;
    let currentN = n;

    if (currentN < 0) {
        x = 1 / x;
        currentN = -currentN;
    }

    while (currentN > 0) {
        if (currentN % 2 === 1) {
            ans *= x;
        }
        x *= x;
        currentN = Math.floor(currentN / 2);
    }

    return ans;
};