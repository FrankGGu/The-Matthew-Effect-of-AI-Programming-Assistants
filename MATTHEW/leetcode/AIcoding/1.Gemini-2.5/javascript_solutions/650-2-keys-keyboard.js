var minSteps = function(n) {
    if (n === 1) {
        return 0;
    }

    let ans = 0;
    let d = 2;

    while (n > 1) {
        while (n % d === 0) {
            ans += d;
            n /= d;
        }
        d++;
    }

    return ans;
};