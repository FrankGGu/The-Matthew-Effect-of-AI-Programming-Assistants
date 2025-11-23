var isReachable = function(targetX, targetY) {
    function gcd(a, b) {
        while (b) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    let g = gcd(targetX, targetY);
    return (g & (g - 1)) === 0;
};