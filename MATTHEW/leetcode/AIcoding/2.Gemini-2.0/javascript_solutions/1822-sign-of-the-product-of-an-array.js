var arraySign = function(nums) {
    let product = 1;
    for (let num of nums) {
        if (num === 0) {
            return 0;
        } else if (num < 0) {
            product *= -1;
        }
    }
    return product;
};