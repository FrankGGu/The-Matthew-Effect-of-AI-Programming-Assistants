var arraySign = function(nums) {
    let product = 1;
    for (let num of nums) {
        if (num === 0) return 0;
        product *= num > 0 ? 1 : -1;
    }
    return product > 0 ? 1 : -1;
};