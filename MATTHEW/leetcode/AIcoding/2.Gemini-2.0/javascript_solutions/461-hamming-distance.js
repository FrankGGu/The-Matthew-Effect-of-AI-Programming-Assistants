var hammingDistance = function(x, y) {
    let xor = x ^ y;
    let distance = 0;
    while (xor > 0) {
        distance += xor & 1;
        xor >>= 1;
    }
    return distance;
};