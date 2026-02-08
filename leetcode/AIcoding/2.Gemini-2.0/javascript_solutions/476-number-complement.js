var findComplement = function(num) {
    let bitmask = 0;
    let temp = num;
    while (temp > 0) {
        bitmask = (bitmask << 1) | 1;
        temp = temp >> 1;
    }
    return num ^ bitmask;
};