var isReachable = function(targetX, targetY) {
    function gcd(a, b) {
        while (b !== 0) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    return gcd(targetX, targetY) === 1;
};