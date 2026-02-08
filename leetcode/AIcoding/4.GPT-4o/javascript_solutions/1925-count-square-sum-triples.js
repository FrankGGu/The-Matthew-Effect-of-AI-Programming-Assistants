var countTriplets = function(n) {
    let count = 0;
    for (let a = 1; a <= n; a++) {
        for (let b = a; b <= n; b++) {
            let cSquare = a * a + b * b;
            let c = Math.floor(Math.sqrt(cSquare));
            if (c * c === cSquare && c <= n) {
                count++;
            }
        }
    }
    return count;
};