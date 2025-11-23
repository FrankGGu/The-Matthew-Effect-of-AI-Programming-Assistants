var zeroEvenOdd = function(zero, even, odd) {
    let n = 0;
    while (n < 100) {
        zero();
        n++;
        if (n % 2 === 0) {
            even();
        } else {
            odd();
        }
    }
};