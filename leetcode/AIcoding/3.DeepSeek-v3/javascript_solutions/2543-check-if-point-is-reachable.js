var isReachable = function(targetX, targetY) {
    while (targetX % 2 === 0) {
        targetX /= 2;
    }
    while (targetY % 2 === 0) {
        targetY /= 2;
    }
    return gcd(targetX, targetY) === 1;
};

function gcd(a, b) {
    while (b !== 0) {
        let temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}