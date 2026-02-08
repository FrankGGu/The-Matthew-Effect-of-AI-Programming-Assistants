var reverse = function(x) {
    let reversed = 0;
    const sign = x < 0 ? -1 : 1;
    x = Math.abs(x);

    while (x > 0) {
        const digit = x % 10;
        reversed = reversed * 10 + digit;
        x = Math.floor(x / 10);
    }

    reversed *= sign;

    if (reversed < Math.pow(-2, 31) || reversed > Math.pow(2, 31) - 1) {
        return 0;
    }

    return reversed;
};