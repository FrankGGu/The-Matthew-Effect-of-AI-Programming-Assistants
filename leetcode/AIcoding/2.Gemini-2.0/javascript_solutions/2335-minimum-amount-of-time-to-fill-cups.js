var fillCups = function(amount) {
    amount.sort((a, b) => a - b);
    let a = amount[0];
    let b = amount[1];
    let c = amount[2];

    if (a + b <= c) {
        return c;
    } else {
        return Math.ceil((a + b + c) / 2);
    }
};