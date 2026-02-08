var integerReplacement = function(n) {
    let count = 0;
    while (n !== 1) {
        if (n % 2 === 0) {
            n /= 2;
        } else {
            if (n === 3) {
                n--;
            } else if ((n & 3) === 1) { // n % 4 === 1
                n--;
            } else { // n % 4 === 3
                n++;
            }
        }
        count++;
    }
    return count;
};