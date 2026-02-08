var hammingDistance = function(x, y) {
    let xorResult = x ^ y;
    let distance = 0;
    while (xorResult !== 0) {
        xorResult &= (xorResult - 1);
        distance++;
    }
    return distance;
};