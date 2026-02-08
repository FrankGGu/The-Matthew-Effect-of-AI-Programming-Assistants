var reverse = function(x) {
    let reversed = 0;
    const sign = x < 0 ? -1 : 1;
    x = Math.abs(x);

    while (x > 0) {
        const digit = x % 10;
        x = Math.floor(x / 10);

        if (reversed > Math.floor((2**31 - 1) / 10)) return 0;
        if (reversed === Math.floor((2**31 - 1) / 10) && digit > 7) return 0;

        if (reversed < Math.ceil((-2)**31 / 10)) return 0;
        if (reversed === Math.ceil((-2)**31 / 10) && digit < -8) return 0;

        reversed = reversed * 10 + digit;
    }

    reversed = reversed * sign;

    if (reversed > (2**31 - 1) || reversed < (-2)**31) return 0;

    return reversed;
};