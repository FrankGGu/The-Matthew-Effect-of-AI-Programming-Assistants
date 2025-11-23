function maximumProduct(num) {
    let max1 = -1, max2 = -1;
    for (let i = 0; i < num.length; i++) {
        const digit = parseInt(num[i]);
        if (digit > max1) {
            max2 = max1;
            max1 = digit;
        } else if (digit > max2) {
            max2 = digit;
        }
    }
    return max1 * max2;
}