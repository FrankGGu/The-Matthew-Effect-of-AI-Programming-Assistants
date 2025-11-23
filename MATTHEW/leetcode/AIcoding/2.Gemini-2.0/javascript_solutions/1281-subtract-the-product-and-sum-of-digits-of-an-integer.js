var subtractProductAndSum = function(n) {
    let product = 1;
    let sum = 0;
    const s = n.toString();
    for (let i = 0; i < s.length; i++) {
        const digit = parseInt(s[i]);
        product *= digit;
        sum += digit;
    }
    return product - sum;
};