var maxProduct = function(n) {
    let max = 0;
    let digits = n.toString().split('');
    for (let i = 0; i < digits.length; i++) {
        for (let j = i + 1; j < digits.length; j++) {
            let product = digits[i] * digits[j];
            max = Math.max(max, product);
        }
    }
    return max;
};