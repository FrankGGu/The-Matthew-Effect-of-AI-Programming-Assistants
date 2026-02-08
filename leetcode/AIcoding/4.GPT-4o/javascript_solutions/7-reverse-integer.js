var reverse = function(x) {
    const sign = x < 0 ? -1 : 1;
    const reversed = parseInt(Math.abs(x).toString().split('').reverse().join('')) * sign;
    return (reversed < Math.pow(-2, 31) || reversed > Math.pow(2, 31) - 1) ? 0 : reversed;
};