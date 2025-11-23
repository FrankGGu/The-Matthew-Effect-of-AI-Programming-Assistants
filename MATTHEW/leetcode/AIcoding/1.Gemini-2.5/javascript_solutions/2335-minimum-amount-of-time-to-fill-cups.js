var fillCups = function(cups) {
    cups.sort((a, b) => a - b);

    let a = cups[0];
    let b = cups[1];
    let c = cups[2];

    if (a + b <= c) {
        return c;
    } else {
        return Math.ceil((a + b + c) / 2);
    }
};