var reachNumber = function(target) {
    target = Math.abs(target);
    let k = 0;
    let sum = 0;
    while (sum < target || (sum - target) % 2 !== 0) {
        k++;
        sum += k;
    }
    return k;
};