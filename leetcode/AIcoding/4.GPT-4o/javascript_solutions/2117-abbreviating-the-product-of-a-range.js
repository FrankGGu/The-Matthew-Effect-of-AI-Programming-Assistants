var abbreviateProduct = function(left, right) {
    let product = BigInt(1);
    let countZeros = 0;

    for (let i = left; i <= right; i++) {
        product *= BigInt(i);
    }

    while (product % BigInt(10) === BigInt(0)) {
        product /= BigInt(10);
        countZeros++;
    }

    let productStr = product.toString();
    let length = productStr.length;

    if (length <= 10) {
        return productStr + (countZeros > 0 ? '0'.repeat(countZeros) : '');
    }

    return productStr.slice(0, 1) + 'e' + (length - 1 + countZeros);
};