var findComplement = function(num) {
    return num ^ ((1 << num.toString(2).length) - 1);
};