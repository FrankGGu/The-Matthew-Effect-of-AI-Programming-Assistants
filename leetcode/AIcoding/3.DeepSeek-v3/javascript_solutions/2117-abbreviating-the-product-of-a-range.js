var abbreviateProduct = function(left, right) {
    let product = BigInt(1);
    let countZero = 0;
    for (let i = left; i <= right; i++) {
        product *= BigInt(i);
        while (product % BigInt(10) === BigInt(0)) {
            product /= BigInt(10);
            countZero++;
        }
    }
    let s = product.toString();
    if (s.length <= 10) {
        return s + 'e' + countZero;
    } else {
        let firstFive = s.substring(0, 5);
        let lastFive = s.substring(s.length - 5);
        return firstFive + '...' + lastFive + 'e' + countZero;
    }
};